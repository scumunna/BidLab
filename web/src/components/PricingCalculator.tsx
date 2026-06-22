// Pricing calculator, ported from the native PricingCalculator. The core adtech
// identity: a CPM, a click-through rate, and a conversion rate determine your
// effective CPC and CPA. Drag any input and watch the cost per outcome move.

import { useState } from 'react'
import { Pricing } from '../engine'
import { money, pct } from '../format'
import { C, card, SectionHeader, Slider } from './ui'

export function PricingCalculator() {
  const [cpm, setCpm] = useState(8)
  const [ctr, setCtr] = useState(0.008)
  const [cvr, setCvr] = useState(0.05)

  const cpc = Pricing.cpc(cpm, ctr)
  const cpa = Pricing.cpa(cpc, cvr)
  const convPer1k = ctr * cvr * 1000

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-sales">PRICING CALCULATOR</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">CPM → CPC → CPA</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Pricing Calculator" subtitle="What does a click — and a conversion — actually cost at this CPM?" />
      </div>

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        <div className={`${card} flex flex-col gap-3`}>
          <Slider label="CPM" value={cpm} min={1} max={50} step={0.5} display={money(cpm, 2)} color={C.sales} onChange={setCpm} />
          <Slider label="CTR" value={ctr} min={0.001} max={0.05} step={0.001} display={pct(ctr, 2)} color={C.sales} onChange={setCtr} />
          <Slider label="CVR" value={cvr} min={0.005} max={0.25} step={0.005} display={pct(cvr, 1)} color={C.sales} onChange={setCvr} />
        </div>

        <div className="grid grid-cols-1 gap-3 sm:grid-cols-3">
          <BigStat label="Effective CPC" value={money(cpc, 2)} color={C.sales} />
          <BigStat label="Effective CPA" value={money(cpa, 2)} color={C.violet} />
          <BigStat label="Conv. / 1k impressions" value={convPer1k.toFixed(2)} color={C.up} />
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-sales/20 bg-sales/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-sales">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">CPC = CPM / (CTR · 1000),  CPA = CPC / CVR</p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>CPM is what you pay per thousand impressions; CTR and CVR convert those into clicks and actions.</li>
          <li>A low CPM can still mean an expensive CPA if the funnel converts poorly — outcomes, not impressions, are the cost.</li>
          <li>Conversions per 1,000 impressions = CTR × CVR × 1000, the funnel in a single number.</li>
        </ul>
      </div>
    </section>
  )
}

function BigStat({ label, value, color }: { label: string; value: string; color: string }) {
  return (
    <div className="flex flex-col gap-1 rounded-2xl border border-white/10 bg-white/[0.03] p-4">
      <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">{label}</span>
      <span className="font-mono text-3xl font-extrabold tabular-nums" style={{ color }}>
        {value}
      </span>
    </div>
  )
}
