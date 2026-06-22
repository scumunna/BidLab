// Reach & frequency explorable, ported from the native ReachFrequencyPlayground.
// Drag total impressions and watch unique reach, average frequency, and effective
// reach (2+/3+) move along the bending reach curve — impressions modeled as
// Poisson-distributed across the population.

import { useMemo, useState } from 'react'
import { ReachFrequency as RF } from '../engine'
import { pct } from '../format'
import { LineChart, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

const POPULATION = 1_000_000
const MAX_IMPRESSIONS = POPULATION * 3
const millions = (x: number) => `${(x / 1_000_000).toFixed(2)}M`

export function ReachFrequency() {
  const [impressions, setImpressions] = useState(1_000_000)

  const reachFrac = RF.reachFraction(POPULATION, impressions)
  const avgFreq = RF.averageFrequency(POPULATION, impressions)
  const eff2Frac = RF.effectiveReach(POPULATION, impressions, 2) / POPULATION
  const eff3Frac = RF.effectiveReach(POPULATION, impressions, 3) / POPULATION

  const curve = useMemo<ChartPoint[]>(() => {
    const n = 100
    return Array.from({ length: n + 1 }, (_, i) => {
      const imp = (MAX_IMPRESSIONS * i) / n
      return { x: imp, y: RF.reachFraction(POPULATION, imp) }
    })
  }, [])

  const reachedCount = Math.min(100, Math.round(reachFrac * 100))
  const reached2 = Math.min(reachedCount, Math.round(eff2Frac * 100))

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-planning">REACH &amp; FREQUENCY</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">{millions(POPULATION)} people</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Reach &amp; Frequency" subtitle="How many unique people you hit — and how often — as impressions pile up." />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider
              label="Impressions"
              value={impressions}
              min={0}
              max={MAX_IMPRESSIONS}
              step={MAX_IMPRESSIONS / 1000}
              display={millions(impressions)}
              color={C.planning}
              onChange={setImpressions}
            />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Unique reach" value={pct(reachFrac)} color={C.planning} />
              <StatRow label="Average frequency" value={avgFreq.toFixed(2)} />
              <StatRow label="Reached 2+ times" value={pct(eff2Frac)} color={C.analytics} />
              <StatRow label="Reached 3+ times" value={pct(eff3Frac)} color={C.muted} />
            </div>
          </div>

          <div className={card}>
            <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">100 people in the audience</div>
            <div className="mt-3 grid gap-[5px]" style={{ gridTemplateColumns: 'repeat(20, minmax(0, 1fr))' }} aria-hidden>
              {Array.from({ length: 100 }, (_, i) => {
                const color = i < reached2 ? C.planning : i < reachedCount ? 'rgba(255,159,28,0.4)' : 'rgba(255,255,255,0.10)'
                return <span key={i} className="aspect-square rounded-full" style={{ backgroundColor: color }} />
              })}
            </div>
            <div className="mt-3 flex flex-wrap gap-x-4 gap-y-1">
              <Legend color="rgba(255,159,28,0.4)" label="reached once" />
              <Legend color={C.planning} label="reached 2+" />
              <Legend color="rgba(255,255,255,0.10)" label="not reached" />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.planning} label="unique reach (% of population)" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[{ color: C.planning, points: curve, fill: true }]}
              xDomain={[0, MAX_IMPRESSIONS]}
              yDomain={[0, 1]}
              markers={[{ kind: 'vertical', x: impressions, color: C.planning }]}
              ariaLabel="Unique reach as a fraction of the population versus total impressions"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>0 impressions</span>
            <span>{millions(MAX_IMPRESSIONS)}</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-planning/20 bg-planning/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-planning">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">reach = population · (1 − e^(−impressions / population))</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Impressions land randomly across {millions(POPULATION)} people, so the hits any one person gets follow a Poisson distribution with mean λ = impressions / population.</li>
          <li>Unique reach is the share hit at least once; effective reach (2+/3+) is the Poisson tail.</li>
          <li>Diminishing returns: as impressions climb, extra spend mostly raises frequency on people already reached, not new reach.</li>
        </ul>
      </div>
    </section>
  )
}
