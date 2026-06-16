import Foundation

/// A single learner parsed from an exported transcript. BidLab runs locally, so
/// a manager rolls a team up by importing each learner's transcript file rather
/// than reading from a server. This is the offline, honest version of a cohort
/// dashboard.
/// Whether an imported transcript's signature checks out. A learner-set name on
/// a plaintext file is only trustworthy if the file is tamper-evident, so the
/// roll-up surfaces this per row.
public enum TranscriptVerification: String, Equatable {
    case verified   // signature present and matches the data
    case tampered   // signature present but does not match (file was edited)
    case unsigned   // no signature line (older export or hand-made file)
}

public struct LearnerRecord: Equatable {
    public let name: String
    public let lessonsCompleted: Int
    public let lessonsTotal: Int
    public let certificationsEarned: Int
    public let bestTradingScore: Int
    public let xp: Int
    public let dayStreak: Int
    public let verification: TranscriptVerification

    public init(name: String, lessonsCompleted: Int, lessonsTotal: Int,
                certificationsEarned: Int, bestTradingScore: Int, xp: Int, dayStreak: Int,
                verification: TranscriptVerification = .unsigned) {
        self.name = name
        self.lessonsCompleted = lessonsCompleted
        self.lessonsTotal = lessonsTotal
        self.certificationsEarned = certificationsEarned
        self.bestTradingScore = bestTradingScore
        self.xp = xp
        self.dayStreak = dayStreak
        self.verification = verification
    }

    /// Fraction of the live curriculum this learner has completed, in `0...1`.
    public var completionFraction: Double {
        lessonsTotal > 0 ? Double(lessonsCompleted) / Double(lessonsTotal) : 0
    }
}

/// Aggregate stats across an imported cohort, for the manager summary cards.
public struct CohortSummary: Equatable {
    public let learnerCount: Int
    public let avgCompletion: Double        // 0...1
    public let totalCertifications: Int
    public let certifiedLearners: Int       // learners with at least one certification
    public let avgBestScore: Double         // over learners who have run the simulator

    public init(learnerCount: Int, avgCompletion: Double, totalCertifications: Int,
                certifiedLearners: Int, avgBestScore: Double) {
        self.learnerCount = learnerCount
        self.avgCompletion = avgCompletion
        self.totalCertifications = totalCertifications
        self.certifiedLearners = certifiedLearners
        self.avgBestScore = avgBestScore
    }
}

public enum Cohort {
    /// A deterministic, tamper-evident signature over a transcript's data fields,
    /// using the same hash and BL-XXXX-XXXX format as the credential code. The
    /// exporter writes it and the roll-up recomputes it to detect edits. With an
    /// open-source app this is tamper-evidence (it catches a hand-edited file),
    /// not third-party authentication.
    public static func transcriptSignature(name: String, lessonsCompleted: Int, lessonsTotal: Int,
                                           certifications: Int, bestTradingScore: Int, xp: Int, dayStreak: Int) -> String {
        let seed = "\(name)|\(lessonsCompleted)|\(lessonsTotal)|\(certifications)|\(bestTradingScore)|\(xp)|\(dayStreak)"
        let raw = String(StableID.hash(seed), radix: 36).uppercased()
        let padded = raw + String(repeating: "0", count: max(0, 8 - raw.count))
        return "BL-\(padded.prefix(4))-\(padded.dropFirst(4).prefix(4))"
    }

    /// The signature a record's data should carry.
    public static func signature(for r: LearnerRecord) -> String {
        transcriptSignature(name: r.name, lessonsCompleted: r.lessonsCompleted, lessonsTotal: r.lessonsTotal,
                            certifications: r.certificationsEarned, bestTradingScore: r.bestTradingScore,
                            xp: r.xp, dayStreak: r.dayStreak)
    }

    /// Parse one exported transcript CSV into a learner record. Tolerant of the
    /// optional leading `learner,<name>` line and reads the `summary,value` block;
    /// returns nil only if no summary block is present.
    public static func parseTranscript(_ csv: String) -> LearnerRecord? {
        let lines = csv.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        var name = ""
        var summary: [String: String] = [:]
        var inSummary = false
        for line in lines {
            let lower = line.lowercased()
            if lower.hasPrefix("learner,") {
                name = String(line.dropFirst("learner,".count)).trimmingCharacters(in: .whitespaces)
            } else if lower == "summary,value" {
                inSummary = true
            } else if inSummary, let comma = line.firstIndex(of: ",") {
                let key = String(line[..<comma]).trimmingCharacters(in: .whitespaces)
                let value = String(line[line.index(after: comma)...]).trimmingCharacters(in: .whitespaces)
                if !key.isEmpty { summary[key] = value }
            }
        }
        guard !summary.isEmpty else { return nil }
        func intVal(_ key: String) -> Int { Int(summary[key] ?? "") ?? 0 }
        let resolvedName = name.isEmpty ? "Unnamed learner" : name
        let expected = transcriptSignature(
            name: resolvedName,
            lessonsCompleted: intVal("lessons_completed_total"),
            lessonsTotal: intVal("lessons_total"),
            certifications: intVal("certifications_earned"),
            bestTradingScore: intVal("best_trading_score"),
            xp: intVal("xp"),
            dayStreak: intVal("day_streak")
        )
        let verification: TranscriptVerification
        if let provided = summary["signature"], !provided.isEmpty {
            verification = provided.uppercased() == expected ? .verified : .tampered
        } else {
            verification = .unsigned
        }
        return LearnerRecord(
            name: resolvedName,
            lessonsCompleted: intVal("lessons_completed_total"),
            lessonsTotal: intVal("lessons_total"),
            certificationsEarned: intVal("certifications_earned"),
            bestTradingScore: intVal("best_trading_score"),
            xp: intVal("xp"),
            dayStreak: intVal("day_streak"),
            verification: verification
        )
    }

    /// Parse several transcript files into records, dropping any that fail.
    public static func parseAll(_ files: [String]) -> [LearnerRecord] {
        files.compactMap { parseTranscript($0) }
    }

    /// Roll a set of learner records into the manager summary.
    public static func summarize(_ records: [LearnerRecord]) -> CohortSummary {
        guard !records.isEmpty else {
            return CohortSummary(learnerCount: 0, avgCompletion: 0, totalCertifications: 0,
                                 certifiedLearners: 0, avgBestScore: 0)
        }
        let n = Double(records.count)
        let avgCompletion = records.map(\.completionFraction).reduce(0, +) / n
        let totalCerts = records.map(\.certificationsEarned).reduce(0, +)
        let certified = records.filter { $0.certificationsEarned > 0 }.count
        let scorers = records.filter { $0.bestTradingScore > 0 }
        let avgScore = scorers.isEmpty ? 0 : Double(scorers.map(\.bestTradingScore).reduce(0, +)) / Double(scorers.count)
        return CohortSummary(learnerCount: records.count, avgCompletion: avgCompletion,
                             totalCertifications: totalCerts, certifiedLearners: certified,
                             avgBestScore: avgScore)
    }

    /// A combined CSV, one row per learner, for a manager report or an LMS.
    public static func reportCSV(_ records: [LearnerRecord]) -> String {
        var lines = ["learner,lessons_completed,lessons_total,completion_pct,certifications,best_trading_score,xp,day_streak,verification"]
        for r in records {
            let pct = Int((r.completionFraction * 100).rounded())
            // Quote the name so a comma in it cannot break the row.
            lines.append("\"\(r.name)\",\(r.lessonsCompleted),\(r.lessonsTotal),\(pct),\(r.certificationsEarned),\(r.bestTradingScore),\(r.xp),\(r.dayStreak),\(r.verification.rawValue)")
        }
        return lines.joined(separator: "\n")
    }
}
