// Normal distribution explorable, ported from the native DistributionExplorer.
// Slide z and read the cumulative probability and the two-sided tail — the
// machinery under confidence intervals, p-values, and the A/B power math.

import { useMemo, useState } from 'react'
import { Probability, normalCDF } from '../engine'
import { pct } from '../format'
import { LineChart, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

export function Distribution() {
  const [z, setZ] = useState(0)

  const curve = useMemo<ChartPoint[]>(() => {
    const pts: ChartPoint[] = []
    for (let x = -4; x <= 4.0001; x += 0.08) pts.push({ x, y: Probability.normalPDF(x) })
    return pts
  }, [])
  const leftArea = curve.filter((p) => p.x <= z)

  const cdf = normalCDF(z)
  const twoSided = 2 * (1 - normalCDF(Math.abs(z)))

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-analytics">DISTRIBUTION</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">standard normal</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Normal Distribution" subtitle="The curve behind confidence intervals and p-values. Slide z and read the probabilities." />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="z" value={z} min={-3} max={3} step={0.01} display={z.toFixed(2)} color={C.analytics} onChange={setZ} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="P(X ≤ z)" value={pct(cdf, 1)} color={C.analytics} />
              <StatRow label="Two-sided tail" value={pct(twoSided, 1)} color={C.muted} />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.analytics} label="density" />
            <Legend color={C.analytics} label="P(X ≤ z)" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[
                { color: C.analytics, points: leftArea, fill: true, width: 0 },
                { color: C.analytics, points: curve, width: 2.5 },
              ]}
              xDomain={[-4, 4]}
              yDomain={[0, 0.45]}
              markers={[{ kind: 'vertical', x: z, color: C.analytics }]}
              ariaLabel="Standard normal density with the area to the left of z shaded as the cumulative probability"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>−4σ</span>
            <span>+4σ</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">Φ(z) = P(X ≤ z),  two-sided tail = 2·(1 − Φ(|z|))</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>The shaded area is the cumulative probability — the chance a standard normal draw lands at or below z.</li>
          <li>z = 1.96 leaves 2.5% in each tail — the basis of the 95% confidence interval.</li>
          <li>The two-sided tail is the p-value logic: how surprising a result at least this extreme would be under the null.</li>
        </ul>
      </div>
    </section>
  )
}
