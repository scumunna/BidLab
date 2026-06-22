// Latency & timeout explorable, ported from the native LatencySimulator. A DSP
// bidder must answer in time or it never enters the auction; with exponential
// service time, the share lost to a timeout is e^(-timeout/mean), and the tail
// (p99) sits far past the mean.

import { useMemo, useState } from 'react'
import { Systems } from '../engine'
import { pct } from '../format'
import { LineChart, type ChartPoint } from './LineChart'
import { C, card, Legend, SectionHeader, Slider, StatRow } from './ui'

export function Latency() {
  const [mean, setMean] = useState(40)
  const [timeoutMs, setTimeoutMs] = useState(100)

  const curve = useMemo<ChartPoint[]>(
    () => Array.from({ length: 101 }, (_, i) => {
      const x = (300 * i) / 100
      return { x, y: (1 / mean) * Math.exp(-x / mean) }
    }),
    [mean],
  )
  const tail = curve.filter((p) => p.x >= timeoutMs)

  const p50 = Systems.latencyQuantile(mean, 0.5)
  const p99 = Systems.latencyQuantile(mean, 0.99)
  const loss = Systems.timeoutLossRate(mean, timeoutMs)
  const yMax = (1 / mean) * 1.05

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-engineering">LATENCY &amp; TIMEOUT</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">exponential service time</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Latency &amp; Timeout" subtitle="Bid in time or you never enter the auction. How much demand does your latency tail cost you?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Mean latency" value={mean} min={5} max={120} step={1} display={`${mean.toFixed(0)} ms`} color={C.engineering} onChange={setMean} />
            <Slider label="Auction timeout" value={timeoutMs} min={30} max={300} step={5} display={`${timeoutMs.toFixed(0)} ms`} color={C.down} onChange={setTimeoutMs} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Median (p50)" value={`${p50.toFixed(0)} ms`} color={C.engineering} />
              <StatRow label="Tail (p99)" value={`${p99.toFixed(0)} ms`} color={C.planning} />
              <StatRow label="Lost to timeout" value={pct(loss, 2)} color={loss > 0.05 ? C.down : C.up} />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.engineering} label="latency density" />
            <Legend color={C.down} label="lost past timeout" />
          </div>
          <div className="mt-3">
            <LineChart
              series={[
                { color: C.down, points: tail, fill: true, width: 0 },
                { color: C.engineering, points: curve, width: 2.5 },
              ]}
              xDomain={[0, 300]}
              yDomain={[0, yMax]}
              markers={[{ kind: 'vertical', x: timeoutMs, color: C.down }]}
              ariaLabel="Latency probability density with the timeout marked; the shaded tail beyond it is lost demand"
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>0 ms</span>
            <span>300 ms</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-engineering/20 bg-engineering/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-engineering">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">P(lost) = P(latency &gt; timeout) = e^(−timeout / mean),  p₉₉ = −mean · ln(0.01)</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Service time is modeled as exponential, so the tail is long: the p99 is far past the mean.</li>
          <li>Every request slower than the timeout is a dropped bid — lost demand, not just a slow one.</li>
          <li>Halving mean latency cuts the lost-to-timeout share far more than linearly, which is why bidder latency work pays off.</li>
        </ul>
      </div>
    </section>
  )
}
