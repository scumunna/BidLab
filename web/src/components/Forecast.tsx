// Forecast explorable, ported from the native ForecastExplorer. Fit a linear
// trend (OLS) to a fixed history and project it forward; the R² says how much to
// trust the line.

import { useMemo, useState } from 'react'
import { Analytics } from '../engine'
import { LineChart, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

const HISTORY = [10, 12, 11, 14, 16, 15, 18, 20]
const XS = HISTORY.map((_, i) => i)
const FIT = Analytics.linearFit(XS, HISTORY)

export function Forecast() {
  const [horizon, setHorizon] = useState(4)
  const lastX = HISTORY.length - 1 + horizon
  const projected = FIT.intercept + FIT.slope * lastX

  const historyPts = useMemo<ChartPoint[]>(() => XS.map((x, i) => ({ x, y: HISTORY[i] })), [])
  const fitPts: ChartPoint[] = [
    { x: 0, y: FIT.intercept },
    { x: lastX, y: projected },
  ]
  const yMax = Math.max(30, projected * 1.1)

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-analytics">FORECAST</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">ordinary least squares</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Forecast" subtitle="Fit a trend to the history and project it forward — and check how much the fit is worth trusting." />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Forecast horizon" value={horizon} min={1} max={12} step={1} display={`${horizon} wk`} color={C.analytics} onChange={setHorizon} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Trend per week" value={`+${FIT.slope.toFixed(2)}`} color={C.analytics} />
              <StatRow label="Fit quality (R²)" value={FIT.r2.toFixed(2)} color={FIT.r2 >= 0.8 ? C.up : C.planning} />
              <StatRow label={`Projected (week ${lastX + 1})`} value={projected.toFixed(1)} color={C.up} />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.muted} label="history" />
            <Legend color={C.analytics} label="trend" />
            <Legend color={C.up} label="projection" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[
                { color: C.analytics, points: fitPts, width: 2 },
                { color: C.muted, points: historyPts, width: 2 },
              ]}
              xDomain={[0, lastX]}
              yDomain={[0, yMax]}
              markers={[{ kind: 'point', x: lastX, y: projected, color: C.up }]}
              ariaLabel="Historical weekly values with a fitted linear trend projected to the forecast horizon"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>week 1</span>
            <span>week {lastX + 1}</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">ŷ = slope · x + intercept,  fit by ordinary least squares</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>The slope is the average week-over-week change; the intercept is the fitted starting point.</li>
          <li>R² is the share of variance the line explains — near 1 means a tight trend, near 0 means noise.</li>
          <li>A straight line can't see seasonality or saturation, so the further out you project, the more caution it deserves.</li>
        </ul>
      </div>
    </section>
  )
}
