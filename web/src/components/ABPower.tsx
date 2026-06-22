// A/B test power & sample-size explorable, built on BidLabCore's Analytics.power
// and sampleSizePerArm. Set a baseline conversion rate, the lift you want to
// detect, and your per-arm sample size; see your statistical power and how many
// users per arm you'd actually need for 80% power.

import { useMemo, useState } from 'react'
import { Analytics as AN } from '../engine'
import { intc, pct } from '../format'
import { LineChart, type ChartMarker, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

const ALPHA = 0.05
const TARGET_POWER = 0.8

export function ABPower() {
  const [baseline, setBaseline] = useState(0.05)
  const [mde, setMde] = useState(0.01)
  const [nPerArm, setNPerArm] = useState(10_000)

  const currentPower = AN.power(baseline, mde, nPerArm, ALPHA)
  const requiredN = AN.sampleSizePerArm(baseline, mde, ALPHA, TARGET_POWER)
  const relativeLift = baseline > 0 ? mde / baseline : 0

  const maxN = useMemo(() => {
    const target = Math.max(requiredN * 2.2, nPerArm * 1.3, 2000)
    return Math.min(Math.max(target, 2000), 500_000)
  }, [requiredN, nPerArm])

  const curve = useMemo<ChartPoint[]>(() => {
    const n = 120
    return Array.from({ length: n + 1 }, (_, i) => {
      const x = Math.max(1, (maxN * i) / n)
      return { x, y: AN.power(baseline, mde, Math.round(x), ALPHA) }
    })
  }, [baseline, mde, maxN])

  const markers: ChartMarker[] = [
    { kind: 'horizontal', y: TARGET_POWER, color: C.up },
    { kind: 'vertical', x: Math.min(nPerArm, maxN), color: C.analytics },
  ]
  if (requiredN > 0 && requiredN <= maxN) {
    markers.push({ kind: 'point', x: requiredN, y: TARGET_POWER, color: C.up })
  }

  const powerColor = currentPower >= TARGET_POWER ? C.up : C.down
  const verdict =
    requiredN <= 0
      ? 'Pick a non-zero lift to detect.'
      : currentPower >= TARGET_POWER
        ? `At ${intc(nPerArm)}/arm you have ${pct(currentPower, 0)} power — enough to detect this lift. The 80% threshold needs ~${intc(requiredN)}/arm.`
        : `At ${intc(nPerArm)}/arm you only have ${pct(currentPower, 0)} power. You'd need ~${intc(requiredN)}/arm to reliably detect a ${pct(mde, 1)} lift.`

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-analytics">A/B TEST POWER</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">two-proportion · α = 0.05 · two-sided</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="A/B Test Power" subtitle="Will your test actually detect the lift you care about — and how big does it need to be?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Baseline conversion rate" value={baseline} min={0.01} max={0.3} step={0.005} display={pct(baseline, 1)} color={C.analytics} onChange={setBaseline} />
            <Slider label="Lift to detect (absolute)" value={mde} min={0.001} max={0.05} step={0.001} display={`+${(mde * 100).toFixed(1)}pp`} color={C.lime} onChange={setMde} />
            <Slider label="Sample size per arm" value={nPerArm} min={500} max={100_000} step={500} display={intc(nPerArm)} color={C.planning} onChange={setNPerArm} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Relative lift" value={pct(relativeLift, 1)} />
              <StatRow label="Power at this sample size" value={pct(currentPower, 1)} color={powerColor} />
              <StatRow label="Needed for 80% power" value={`${intc(requiredN)} / arm`} color={C.up} />
            </div>
          </div>

          <div className={card}>
            <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">Verdict</div>
            <p className="mt-2 text-[12.5px] leading-relaxed text-white/70">{verdict}</p>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.analytics} label="power" />
            <Legend color={C.up} label="80% target" />
            <Legend color={C.analytics} label="your sample size" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[{ color: C.analytics, points: curve, fill: true }]}
              xDomain={[0, maxN]}
              yDomain={[0, 1]}
              markers={markers}
              ariaLabel="Statistical power versus sample size per arm, with the 80% target and your current sample size"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>0 / arm</span>
            <span>{intc(Math.round(maxN))} / arm</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">power = Φ( |MDE| / SE − z₍α/2₎ ),  SE = √( p₁(1−p₁)/n + p₂(1−p₂)/n )</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>A two-proportion test at α = 0.05 (two-sided). Power is the chance of detecting a true lift of this size.</li>
          <li>Smaller baselines, smaller lifts, and higher confidence all demand more sample — often more than a campaign can deliver.</li>
          <li>The 80% line is the conventional target; the marked point is the per-arm sample size that reaches it.</li>
        </ul>
      </div>
    </section>
  )
}
