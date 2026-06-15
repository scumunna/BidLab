import Foundation
import SQLite3
import SwiftUI

/// Result of running a query against the in-memory sample database.
struct SQLResult {
    var columns: [String] = []
    var rows: [[String]] = []
    var error: String?
}

/// A tiny in-memory SQLite engine seeded with a realistic ad-events table, for
/// the Analytics SQL lab. Real SQL, real results, so analysts can verify the math.
enum SQLEngine {
    static let schema = """
    CREATE TABLE events(
      day TEXT, channel TEXT, impressions INTEGER, clicks INTEGER, conversions INTEGER, spend REAL
    );
    INSERT INTO events VALUES
    ('2026-06-01','Search',120000,3600,180,900.0),
    ('2026-06-01','Social',200000,2400,96,700.0),
    ('2026-06-01','CTV',80000,400,28,1200.0),
    ('2026-06-02','Search',130000,4100,210,980.0),
    ('2026-06-02','Social',210000,2520,101,720.0),
    ('2026-06-02','CTV',82000,410,30,1230.0),
    ('2026-06-03','Search',125000,3750,190,940.0),
    ('2026-06-03','Social',205000,2460,98,710.0),
    ('2026-06-03','CTV',81000,405,29,1215.0);
    """

    static func run(_ query: String) -> SQLResult {
        var db: OpaquePointer?
        guard sqlite3_open(":memory:", &db) == SQLITE_OK else {
            return SQLResult(error: "could not open database")
        }
        defer { sqlite3_close(db) }
        guard sqlite3_exec(db, schema, nil, nil, nil) == SQLITE_OK else {
            return SQLResult(error: "could not seed sample data")
        }
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK else {
            return SQLResult(error: String(cString: sqlite3_errmsg(db)))
        }
        defer { sqlite3_finalize(stmt) }

        var result = SQLResult()
        let columnCount = sqlite3_column_count(stmt)
        for i in 0..<columnCount {
            result.columns.append(String(cString: sqlite3_column_name(stmt, i)))
        }
        var rowCount = 0
        while sqlite3_step(stmt) == SQLITE_ROW, rowCount < 50 {
            var row: [String] = []
            for i in 0..<columnCount {
                if let text = sqlite3_column_text(stmt, i) {
                    row.append(String(cString: text))
                } else {
                    row.append("NULL")
                }
            }
            result.rows.append(row)
            rowCount += 1
        }
        return result
    }
}

/// The interactive SQL lab: edit a query, run it against the sample events table,
/// and see real results.
struct SQLLab: View {
    let params: [String: String]
    @Local private var query = """
    SELECT channel,
           SUM(spend) AS spend,
           SUM(conversions) AS conv,
           ROUND(SUM(spend) / SUM(conversions), 2) AS cpa
    FROM events
    GROUP BY channel
    ORDER BY cpa;
    """
    @Local private var result = SQLResult()
    @Local private var ran = false

    var body: some View {
        WidgetShell("SQL lab", icon: "tablecells", accent: Brand.analytics, note: "events(day, channel, impressions, clicks, conversions, spend)") {
            TextEditor(text: $query)
                .font(.brandMono(12, .regular))
                .foregroundStyle(Color.white.opacity(0.92))
                .scrollContentBackground(.hidden)
                .frame(height: 120)
                .padding(8)
                .background(Brand.console, in: RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous))

            Button {
                result = SQLEngine.run(query)
                ran = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "play.fill").font(.system(size: 11, weight: .bold))
                    Text("Run query").font(.brandRounded(13, .bold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Brand.analytics, in: Capsule())
            }
            .buttonStyle(.plain)

            if ran {
                if let error = result.error {
                    Text(error).font(.brandMono(12, .regular)).foregroundStyle(Brand.down)
                } else {
                    resultsTable
                    Text("\(result.rows.count) row\(result.rows.count == 1 ? "" : "s")")
                        .font(.brandMono(11, .regular)).foregroundStyle(Brand.muted)
                }
            }
        }
    }

    private var resultsTable: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(result.columns, id: \.self) { col in
                        Text(col).font(.brandMono(11, .semibold)).foregroundStyle(Brand.muted)
                            .frame(minWidth: 84, alignment: .leading).padding(6)
                    }
                }
                ForEach(result.rows.indices, id: \.self) { r in
                    HStack(spacing: 0) {
                        ForEach(result.rows[r].indices, id: \.self) { c in
                            Text(result.rows[r][c]).font(.brandMono(12, .regular)).foregroundStyle(Brand.ink)
                                .frame(minWidth: 84, alignment: .leading).padding(6)
                        }
                    }
                    .background(r % 2 == 0 ? Brand.ink.opacity(0.02) : .clear)
                }
            }
        }
        .overlay(RoundedRectangle(cornerRadius: Metric.radiusMd, style: .continuous).strokeBorder(Brand.hairline, lineWidth: 1))
    }
}
