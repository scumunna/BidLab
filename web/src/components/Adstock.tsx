// Adstock explorable, ported from the native AdstockExplorer. One pulse of spend
// keeps working for weeks: geometric carryover a_t = x_t + decay·a_{t-1}. The
// decay controls how long today's impression lingers.

import { useMemo, useState } from 'react'
import { Analytics } from '../engine'
import { C, card, SectionHeader, Slider, StatRow } from './ui'

const PULSE = [0, 0, 100, 0, 0, 0, 0, 0, 0, 0]

export function Adstock() {
  const [decay, setDecay] = useState(0.5)
  const stocked = useMemo(() => Analytics.adstock(PULSE, decay), [decay])
  const stillActiveWeek6 = stocked[5]

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-analytics">ADSTOCK</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">advertising carryover</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Adstock" subtitle="A burst of advertising keeps working after the spend stops. How long does it linger?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className="flex flex-col gap-4">
          <div className={`${card} flex flex-col gap-3`}>
            <Slider label="Decay" value={decay} min={0} max={0.9} step={0.05} display={pct1(decay)} color={C.analytics} onChange={setDecay} />
            <div className="mt-1 flex flex-col gap-2">
              <StatRow label="Pulse" value="week 3 · 100" color={C.analytics} />
              <StatRow label="Still active in week 6" value={`${stillActiveWeek6.toFixed(1)}%`} color={C.muted} />
              <StatRow label="Half-life" value={decay > 0 ? `${(Math.log(0.5) / Math.log(decay)).toFixed(1)} wk` : '—'} color={C.up} />
            </div>
          </div>
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">Effective impact by week</div>
          <div className="mt-4 flex items-end gap-1.5">
            {stocked.map((v, i) => (
              <div key={i} className="flex flex-1 flex-col items-center justify-end gap-1.5">
                <div
                  className="w-full rounded-t transition-[height] duration-200"
                  style={{ height: `${Math.max(2, (v / 100) * 160)}px`, backgroundColor: i === 2 ? C.analytics : 'rgba(0,180,216,0.45)' }}
                />
                <span className="font-mono text-[9px] text-white/35">{i + 1}</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">aₜ = xₜ + decay · aₜ₋₁</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Each week inherits a fraction (the decay) of the previous week's effect, so a single pulse tails off geometrically.</li>
          <li>Higher decay = longer carryover; it's why last week's campaign still shows up in this week's conversions.</li>
          <li>Adstock is a core building block of media-mix models — ignore it and you misattribute the lag.</li>
        </ul>
      </div>
    </section>
  )
}

function pct1(x: number): string {
  return `${(x * 100).toFixed(0)}%`
}
