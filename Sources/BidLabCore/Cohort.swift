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

/// One path's progress for a learner, parsed from the transcript's per-track
/// rows so a manager can see which paths a team is weak on, not just an average.
public struct TrackProgress: Equatable {
    public let trackID: String
    public let role: String
    public let lessonsCompleted: Int
    public let lessonsTotal: Int
    public let certified: Bool
    public let examScorePct: Int?
    public let examDate: String?

    public init(trackID: String, role: String, lessonsCompleted: Int, lessonsTotal: Int,
                certified: Bool, examScorePct: Int? = nil, examDate: String? = nil) {
        self.trackID = trackID
        self.role = role
        self.lessonsCompleted = lessonsCompleted
        self.lessonsTotal = lessonsTotal
        self.certified = certified
        self.examScorePct = examScorePct
        self.examDate = examDate
    }

    public var completionFraction: Double {
        lessonsTotal > 0 ? Double(lessonsCompleted) / Double(lessonsTotal) : 0
    }
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
    public let tracks: [TrackProgress]

    public init(name: String, lessonsCompleted: Int, lessonsTotal: Int,
                certificationsEarned: Int, bestTradingScore: Int, xp: Int, dayStreak: Int,
                verification: TranscriptVerification = .unsigned, tracks: [TrackProgress] = []) {
        self.name = name
        self.lessonsCompleted = lessonsCompleted
        self.lessonsTotal = lessonsTotal
        self.certificationsEarned = certificationsEarned
        self.bestTradingScore = bestTradingScore
        self.xp = xp
        self.dayStreak = dayStreak
        self.verification = verification
        self.tracks = tracks
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

/// One path rolled up across the whole imported cohort: how many learners are
/// certified and how far along they are, so a manager sees "the team is weak on
/// DSP setup" rather than a single blended completion number.
public struct PathRollup: Equatable {
    public let trackID: String
    public let role: String
    public let learnerCount: Int    // learners whose transcript includes this path
    public let certifiedCount: Int
    public let avgCompletion: Double // 0...1

    public init(trackID: String, role: String, learnerCount: Int, certifiedCount: Int, avgCompletion: Double) {
        self.trackID = trackID
        self.role = role
        self.learnerCount = learnerCount
        self.certifiedCount = certifiedCount
        self.avgCompletion = avgCompletion
    }
}

public enum Cohort {
    /// A deterministic, tamper-evident signature over a transcript's data fields,
    /// using the same hash and BL-XXXX-XXXX format as the credential code. The
    /// exporter writes it and the roll-up recomputes it to detect edits. With an
    /// open-source app this is tamper-evidence (it catches a hand-edited file),
    /// not third-party authentication.
    public static func transcriptSignature(name: String, lessonsCompleted: Int, lessonsTotal: Int,
                                           certifications: Int, bestTradingScore: Int, xp: Int, dayStreak: Int,
                                           tracks: [TrackProgress] = []) -> String {
        // Per-track rows are part of the signed payload (sorted by id so order in
        // the file does not matter), so a per-path certification cannot be edited
        // under a "verified" seal, only the summary.
        let trackPart = tracks
            .sorted { $0.trackID < $1.trackID }
            .map { "\($0.trackID):\($0.lessonsCompleted)/\($0.lessonsTotal):\($0.certified ? 1 : 0):\($0.examScorePct.map(String.init) ?? "")" }
            .joined(separator: ";")
        let seed = "\(name)|\(lessonsCompleted)|\(lessonsTotal)|\(certifications)|\(bestTradingScore)|\(xp)|\(dayStreak)|\(trackPart)"
        let raw = String(StableID.hash(seed), radix: 36).uppercased()
        let padded = raw + String(repeating: "0", count: max(0, 8 - raw.count))
        return "BL-\(padded.prefix(4))-\(padded.dropFirst(4).prefix(4))"
    }

    /// The signature a record's data should carry.
    public static func signature(for r: LearnerRecord) -> String {
        transcriptSignature(name: r.name, lessonsCompleted: r.lessonsCompleted, lessonsTotal: r.lessonsTotal,
                            certifications: r.certificationsEarned, bestTradingScore: r.bestTradingScore,
                            xp: r.xp, dayStreak: r.dayStreak, tracks: r.tracks)
    }

    /// Parse one exported transcript CSV into a learner record. Tolerant of the
    /// optional leading `learner,<name>` line and reads the `summary,value` block;
    /// returns nil only if no summary block is present.
    public static func parseTranscript(_ csv: String) -> LearnerRecord? {
        let lines = csv.components(separatedBy: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        var name = ""
        var summary: [String: String] = [:]
        var tracks: [TrackProgress] = []
        var inSummary = false
        var inTracks = false
        for line in lines {
            let lower = line.lowercased()
            if lower.hasPrefix("learner,") {
                name = String(line.dropFirst("learner,".count)).trimmingCharacters(in: .whitespaces)
            } else if lower.hasPrefix("track,role") {
                inTracks = true // header row; data rows follow until the summary block
            } else if lower == "summary,value" {
                inSummary = true
                inTracks = false
            } else if inTracks {
                let cols = line.split(separator: ",", omittingEmptySubsequences: false).map {
                    $0.trimmingCharacters(in: .whitespaces)
                }
                if cols.count >= 5, !cols[0].isEmpty {
                    tracks.append(TrackProgress(
                        trackID: cols[0], role: cols[1],
                        lessonsCompleted: Int(cols[2]) ?? 0, lessonsTotal: Int(cols[3]) ?? 0,
                        certified: cols[4].lowercased() == "yes",
                        examScorePct: cols.count > 5 ? Int(cols[5]) : nil,
                        examDate: cols.count > 6 && !cols[6].isEmpty ? cols[6] : nil
                    ))
                }
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
            dayStreak: intVal("day_streak"),
            tracks: tracks
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
            verification: verification,
            tracks: tracks
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

    /// Roll the cohort up by path, preserving first-seen path order, so a manager
    /// can see certification and completion per path across the team.
    public static func byPath(_ records: [LearnerRecord]) -> [PathRollup] {
        var order: [String] = []
        var roles: [String: String] = [:]
        var learners: [String: Int] = [:]
        var certified: [String: Int] = [:]
        var completionSum: [String: Double] = [:]
        for r in records {
            for t in r.tracks {
                if learners[t.trackID] == nil { order.append(t.trackID); roles[t.trackID] = t.role }
                learners[t.trackID, default: 0] += 1
                if t.certified { certified[t.trackID, default: 0] += 1 }
                completionSum[t.trackID, default: 0] += t.completionFraction
            }
        }
        return order.map { id in
            let n = learners[id] ?? 0
            return PathRollup(
                trackID: id, role: roles[id] ?? id, learnerCount: n,
                certifiedCount: certified[id] ?? 0,
                avgCompletion: n > 0 ? (completionSum[id] ?? 0) / Double(n) : 0
            )
        }
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
