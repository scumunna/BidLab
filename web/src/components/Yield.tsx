// Yield explorable, ported from the native YieldExplorer — the sell-side view.
// Raising the floor prices out demand, so fill falls; but each filled impression
// earns more. Revenue peaks at floor = mean demand: below it you leave price on
// the table, above it fill collapses faster than price rises.

import { useMemo, useState } from 'react'
import { Yield as Y } from '../engine'
import { money, pct } from '../format'
import { LineChart, type ChartMarker, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

const MAX_FLOOR = 15
const millions = (x: number) => `${(x / 1_000_000).toFixed(1)}M`

export function Yield() {
  const [avails, setAvails] = useState(20_000_000)
  const [demand, setDemand] = useState(4)
  const [floor, setFloor] = useState(2)

  const fill = Y.fillRate(demand, floor)
  const filled = Y.filledImpressions(avails, demand, floor)
  const rev = Y.revenue(avails, demand, floor)
  const optFloor = Y.optimalFloor(demand)

  const curve = useMemo<ChartPoint[]>(() => {
    const n = 120
    return Array.from({ length: n + 1 }, (_, i) => {
      const f = (MAX_FLOOR * i) / n
      return { x: f, y: Y.revenue(avails, demand, f) }
    })
  }, [avails, demand])

  const peakRevenue = Y.revenue(avails, demand, optFloor)
  const yMax = Math.max(peakRevenue * 1.1, 1)
  const markers: ChartMarker[] = [
    { kind: 'vertical', x: floor, color: C.sales },
    { kind: 'point', x: optFloor, y: peakRevenue, color: C.up },
  ]

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-sales">YIELD &amp; FLOORS</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">sell-side · the floor / fill tradeoff</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Yield &amp; Floors" subtitle="Set a price floor too high and demand walks; too low and you give inventory away. Where does revenue peak?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Avails (impressions)" value={avails} min={1_000_000} max={100_000_000} step={1_000_000} display={millions(avails)} color={C.sales} onChange={setAvails} />
            <Slider label="Demand strength (mean CPM)" value={demand} min={1} max={12} step={0.5} display={money(demand, 2)} color={C.sales} onChange={setDemand} />
            <Slider label="Floor CPM" value={floor} min={0.5} max={MAX_FLOOR} step={0.5} display={money(floor, 2)} color={C.down} onChange={setFloor} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Fill rate" value={pct(fill, 1)} color={C.sales} />
              <StatRow label="Filled impressions" value={millions(filled)} />
              <StatRow label="Revenue" value={money(rev, 0)} color={C.up} />
              <StatRow label="Yield-maximizing floor" value={money(optFloor, 2)} color={C.violet} />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.sales} label="revenue" />
            <Legend color={C.down} label="your floor" />
            <Legend color={C.up} label="yield-max floor" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[{ color: C.sales, points: curve, fill: true }]}
              xDomain={[0, MAX_FLOOR]}
              yDomain={[0, yMax]}
              markers={markers}
              ariaLabel="Publisher revenue as a function of the price floor, peaking at the mean demand CPM"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>floor $0</span>
            <span>{money(MAX_FLOOR, 0)} CPM</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-sales/20 bg-sales/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-sales">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">fill = e^(−floor / mean),  revenue = avails · fill · floor / 1000</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Demand is an exponential pool with mean CPM = demand strength; a floor of f fills the share e^(−f/mean).</li>
          <li>Revenue is fill × price, and that product is maximized exactly at floor = mean demand.</li>
          <li>Below the peak you under-price; above it, fill collapses faster than price rises.</li>
        </ul>
      </div>
    </section>
  )
}
