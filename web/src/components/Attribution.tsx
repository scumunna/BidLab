// Attribution explorable, ported from the native AttributionComparison. The same
// conversion, credited three ways across an ordered set of touchpoints — each
// model sums to 1, so the choice of model is purely about *where* credit lands.

import { useState } from 'react'
import { Attribution as A } from '../engine'
import { pct } from '../format'
import { C, Segmented, SectionHeader } from './ui'

const TOUCHES = ['Display', 'Search', 'Social', 'Email']
type Model = 'last' | 'linear' | 'position'

function creditFor(model: Model): number[] {
  if (model === 'last') return A.lastTouch(TOUCHES.length)
  if (model === 'linear') return A.linear(TOUCHES.length)
  return A.positionBased(TOUCHES.length)
}

const BLURB: Record<Model, string> = {
  last: 'Last-touch hands every bit of credit to the final touchpoint — simple, but it flatters whatever sits closest to the conversion (often branded search or retargeting).',
  linear: 'Linear splits credit evenly across all touches — it values the full journey but treats a throwaway impression the same as a decisive one.',
  position: 'Position-based (U-shaped) rewards the first touch (discovery) and last touch (closing) most, with the middle sharing the rest.',
}

export function Attribution() {
  const [model, setModel] = useState<Model>('last')
  const credit = creditFor(model)

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-violet">ATTRIBUTION</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">one conversion · credit sums to 100%</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Attribution" subtitle="Who gets credit for the conversion? The model you pick changes the story — not the sale." />
      </div>

      <div className="mt-5 max-w-[520px]">
        <Segmented
          ariaLabel="Attribution model"
          value={model}
          onChange={setModel}
          options={[
            { label: 'Last touch', value: 'last' },
            { label: 'Linear', value: 'linear' },
            { label: 'Position', value: 'position' },
          ]}
        />
      </div>

      <div className="mt-5 flex flex-col gap-3">
        {TOUCHES.map((t, i) => (
          <div key={t} className="flex flex-col gap-1.5">
            <div className="flex items-baseline justify-between">
              <span className="text-[13px] text-white/80">
                <span className="font-mono text-[10px] text-white/35">{i + 1}.</span> {t}
              </span>
              <span className="font-mono text-[13px] font-bold tabular-nums" style={{ color: C.violet }}>
                {pct(credit[i], 0)}
              </span>
            </div>
            <div className="h-2.5 w-full overflow-hidden rounded-full bg-white/10">
              <div className="h-full rounded-full transition-[width] duration-300" style={{ width: `${Math.max(1, credit[i] * 100)}%`, backgroundColor: C.violet }} />
            </div>
          </div>
        ))}
      </div>

      <div className="mt-5 rounded-2xl border border-violet/20 bg-violet/[0.06] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-violet">Open the hood</div>
        <p className="mt-2 text-[12.5px] leading-relaxed text-white/70">{BLURB[model]}</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Every model distributes exactly one conversion — the credit vector always sums to 100%.</li>
          <li>The “right” model depends on the question: last-touch for closing efficiency, position-based for full-journey value.</li>
          <li>This is rules-based attribution; incrementality testing answers the harder question of what the touch actually *caused*.</li>
        </ul>
      </div>
    </section>
  )
}
