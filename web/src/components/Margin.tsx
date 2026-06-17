// Margin / supply-path explorable, ported from the native MarginModeler. Every
// hop in the chain takes a cut (the "ad-tech tax"); what's left reaches working
// media. Supply-path optimization is the work of shrinking that take.

import { useState } from 'react'
import { money, pct } from '../format'
import { C, card, SectionHeader, Slider, StatRow } from './ui'

export function Margin() {
  const [gross, setGross] = useState(50_000)
  const [take, setTake] = useState(0.15)

  const margin = gross * take
  const net = gross - margin
  const workingPct = gross > 0 ? net / gross : 0
  const workingColor = workingPct >= 0.8 ? C.up : workingPct >= 0.6 ? C.lime : C.down

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-sales">MARGIN &amp; SUPPLY PATH</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">the ad-tech tax</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Margin &amp; Supply Path" subtitle="Every hop takes a cut. How much of the budget actually reaches working media?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className={`${card} flex flex-col gap-3`}>
          <Slider label="Gross spend" value={gross} min={1_000} max={200_000} step={1_000} display={money(gross, 0)} color={C.sales} onChange={setGross} />
          <Slider label="Take rate (total fees)" value={take} min={0.02} max={0.45} step={0.005} display={pct(take, 1)} color={C.sales} onChange={setTake} />
          <div className="mt-1 flex flex-col gap-2">
            <StatRow label="To working media (net)" value={money(net, 0)} color={C.up} />
            <StatRow label="Taken in fees" value={money(margin, 0)} color={C.sales} />
            <StatRow label="Working media share" value={pct(workingPct, 1)} color={workingColor} />
          </div>
        </div>

        <div className="flex flex-col justify-center gap-4 rounded-2xl border border-white/10 bg-white/[0.03] p-5">
          <div>
            <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">Reaches working media</div>
            <div className="font-mono text-5xl font-extrabold tabular-nums" style={{ color: workingColor }}>
              {pct(workingPct, 0)}
            </div>
          </div>
          <div className="flex h-5 w-full overflow-hidden rounded-full">
            <div style={{ width: `${workingPct * 100}%`, backgroundColor: C.up }} />
            <div style={{ flex: 1, backgroundColor: C.sales }} />
          </div>
          <div className="flex justify-between font-mono text-[11px] font-semibold">
            <span style={{ color: C.up }}>{money(net, 0)} to media</span>
            <span style={{ color: C.sales }}>{money(margin, 0)} fees</span>
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-sales/20 bg-sales/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-sales">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">working media = gross · (1 − take)</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>The take rate is the combined cut of every hop — DSP, exchange, SSP, data, and verification fees.</li>
          <li>On a typical chain, a large share of the budget never buys an impression; it pays the pipes.</li>
          <li>Supply-path optimization trims redundant hops to push more of the same budget into working media.</li>
        </ul>
      </div>
    </section>
  )
}
