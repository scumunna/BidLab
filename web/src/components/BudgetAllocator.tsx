// Budget allocation explorable, ported from the native BudgetAllocatorWidget.
// Split a budget across channels with diminishing returns; greedy equimarginal
// allocation hands each dollar to the channel with the highest marginal return.

import { useMemo, useState } from 'react'
import { ResponseCurve, BudgetAllocation } from '../engine'
import { money, pct } from '../format'
import { LineChart, type ChartMarker, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

const CHANNELS = [
  { name: 'Search', curve: new ResponseCurve(1000, 30_000), color: C.planning },
  { name: 'Social', curve: new ResponseCurve(700, 20_000), color: C.analytics },
  { name: 'CTV', curve: new ResponseCurve(1400, 60_000), color: C.up },
]
const CURVES = CHANNELS.map((c) => c.curve)

export function BudgetAllocator() {
  const [budget, setBudget] = useState(100_000)

  const alloc = useMemo(() => BudgetAllocation.allocate(budget, CURVES), [budget])
  const optimal = BudgetAllocation.totalResponse(alloc, CURVES)
  const even = BudgetAllocation.totalResponse(
    CURVES.map(() => budget / CURVES.length),
    CURVES,
  )
  const uplift = even > 0 ? optimal / even - 1 : 0

  const series = CHANNELS.map((c) => ({
    color: c.color,
    width: 2,
    points: Array.from({ length: 81 }, (_, i) => {
      const x = (budget * i) / 80
      return { x, y: c.curve.response(x) }
    }) as ChartPoint[],
  }))
  const markers: ChartMarker[] = CHANNELS.map((c, i) => ({ kind: 'point', x: alloc[i], y: c.curve.response(alloc[i]), color: c.color }))
  const yMax = Math.max(...CHANNELS.map((c) => c.curve.saturation)) * 1.05

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-planning">BUDGET ALLOCATOR</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">equimarginal · diminishing returns</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Budget Allocator" subtitle="Split a budget across channels with diminishing returns — where should the next dollar go?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Total budget" value={budget} min={10_000} max={500_000} step={5_000} display={money(budget, 0)} color={C.planning} onChange={setBudget} />
            <div className="mt-1 flex flex-col gap-3">
              {CHANNELS.map((c, i) => (
                <AllocBar key={c.name} name={c.name} value={alloc[i]} budget={budget} color={c.color} />
              ))}
            </div>
          </div>
          <div className={`${card} flex flex-col gap-2`}>
            <StatRow label="Total outcome (optimal)" value={money(optimal, 0).replace('$', '')} color={C.up} />
            <StatRow label="vs even split" value={money(even, 0).replace('$', '')} color={C.muted} />
            <StatRow label="Uplift from optimizing" value={`+${pct(uplift, 1)}`} color={C.lime} />
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            {CHANNELS.map((c) => (
              <Legend key={c.name} color={c.color} label={c.name} />
            ))}
          </div>
          <div className="mt-3">
            <LineChart series={series} xDomain={[0, budget]} yDomain={[0, yMax]} markers={markers} ariaLabel="Response curve for each channel, with the optimal spend marked on each" />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>$0 spend per channel</span>
            <span>{money(budget, 0)}</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-planning/20 bg-planning/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-planning">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">response(spend) = saturation · (1 − e^(−spend / scale))</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Each channel saturates: the marginal return per dollar strictly decreases as you spend more on it.</li>
          <li>The optimum equalizes marginal returns — give the next dollar to whichever channel returns the most right now.</li>
          <li>An even split leaves money on the table; the uplift is free outcome from allocating, not spending more.</li>
        </ul>
      </div>
    </section>
  )
}

function AllocBar({ name, value, budget, color }: { name: string; value: number; budget: number; color: string }) {
  const frac = budget > 0 ? value / budget : 0
  return (
    <div className="flex flex-col gap-1.5">
      <div className="flex items-baseline justify-between">
        <span className="text-[12.5px] text-white/70">{name}</span>
        <span className="font-mono text-[12px] font-bold tabular-nums" style={{ color }}>
          {money(value, 0)} · {pct(frac, 0)}
        </span>
      </div>
      <div className="h-2 w-full overflow-hidden rounded-full bg-white/10">
        <div className="h-full rounded-full transition-[width] duration-200" style={{ width: `${Math.max(2, frac * 100)}%`, backgroundColor: color }} />
      </div>
    </div>
  )
}
