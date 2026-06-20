// Pixel Setup walkthrough — the conversion-pixel playbook a programmatic trader
// actually follows, as an interactive stepper plus the three calculators the
// curriculum (core-08, adops-13/14) leans on. Same dark console aesthetic and
// transparency ethos as the rest of the suite.

import { useState, type ReactNode } from 'react'
import { Tracking } from '../engine'
import { intc, pct } from '../format'
import { C, card, SectionHeader, Slider, StatRow } from './ui'

interface Step {
  key: string
  title: string
  blurb: string
  code?: string
  checklist: string[]
}

const STEPS: Step[] = [
  {
    key: 'Create',
    title: 'Create the pixel and choose what it counts',
    blurb:
      'In your platform, create the pixel or activity, then pick its counting rule — the choice that bites later. A lead is usually a Counter (unique per user); a purchase is a Sales activity carrying the order value and a unique order id.',
    code: '<!-- CM360 Floodlight sales tag: ord is the ORDER ID, so reloads dedupe -->\n<img src="https://ad.doubleclick.net/ddm/activity/src=1234567;type=purch;cat=order;qty=1;cost=49.90;ord=ORDER-10231?" width="1" height="1" alt="">',
    checklist: ['Counter vs Sales (and unique vs every)', 'Sales activity carries value + a unique order id', 'ord = order id (the dedup key), not a random number'],
  },
  {
    key: 'Place',
    title: 'Place it: global tag sitewide, event on the success page',
    blurb:
      'The global tag goes in the head on every page. The event snippet fires on one page only — the confirmation page — ideally on a dataLayer event the site pushes when the order is truly confirmed.',
    code: "// pushed ONLY after the order is confirmed\ndataLayer.push({\n  event: 'purchase',\n  value: 49.90,\n  currency: 'USD',\n  transaction_id: 'ORDER-10231'   // the dedup key the tag reads\n});",
    checklist: ['Global tag in the head on All Pages', 'Event fires on the confirmation page / dataLayer event', 'Fire on the success event, not the button click'],
  },
  {
    key: 'Windows',
    title: 'Set the attribution windows',
    blurb:
      'Credit only counts inside the lookback window. Set a click-through window to match the sales cycle (often 30 days) and a shorter view-through window (often 1 day), then hold them constant so trends stay comparable.',
    checklist: ['Click-through window matches the sales cycle', 'View-through window kept short (often 1 day)', 'Lock the window before comparing CPA / ROAS'],
  },
  {
    key: 'QA',
    title: 'QA: fire a test and prove it fires',
    blurb:
      'Never release budget on an unproven pixel. Fire a real test conversion end to end and verify every link in the chain before spend goes live. Use the discrepancy check below to sanity it against the back-end.',
    checklist: [
      'Fire a real test conversion end to end',
      'Request returns 200 (devtools / Tag Assistant / Pixel Helper)',
      'value + order id populated, not 0 or undefined',
      'Fires once (the dedup key holds)',
      'Consent Mode v2: fires after accept, suppressed before it (EEA)',
      'Appears in platform reporting with the right value',
    ],
  },
  {
    key: 'Server-side',
    title: 'Recover what the browser drops (CAPI)',
    blurb:
      'Blockers, cookie caps, and bounces drop a meaningful share of client conversions. Send the event from your server too (Conversions API or server-side GTM) with the same event id, so the platform deduplicates instead of double-counting.',
    code: 'POST https://graph.facebook.com/v21.0/<DATASET_ID>/events\n{\n  "data": [{\n    "event_name": "Purchase",\n    "event_id": "ORDER-10231",          // SAME id as the browser pixel\n    "action_source": "website",\n    "user_data": { "em": "<sha256 email>", "ph": "<sha256 phone>" },\n    "custom_data": { "value": 49.90, "currency": "USD" }\n  }]\n}',
    checklist: ['Server posts the event first-party (CAPI / sGTM)', 'Same event_id as the browser pixel (for dedup)', 'EMQ at 7 or higher on the key event', 'Hash user_data (SHA-256 email / phone)'],
  },
  {
    key: 'Troubleshoot',
    title: 'Troubleshoot the silent failures',
    blurb:
      'The page looks fine and spend continues; only the numbers are wrong. When the pixel disagrees with the advertiser back-end by more than about 10%, suspect the implementation before the media.',
    checklist: [
      'Not firing: wrong page / JS error / Consent Mode v2 denied (EEA)',
      'SPA: bind to the route change or dataLayer, not page load',
      'Double-count: tag off the confirmation page / no dedup key',
      'Zero value: dataLayer not populated when the tag read it',
      'Gap over ~10% vs back-end: suspect the implementation',
    ],
  },
]

export function PixelSetup() {
  const [active, setActive] = useState(0)
  const [checked, setChecked] = useState<Record<string, boolean>>({})
  const step = STEPS[active]

  const toggle = (i: number) => setChecked((c) => ({ ...c, [`${step.key}:${i}`]: !c[`${step.key}:${i}`] }))

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <span className="font-mono text-[11px] font-semibold text-lime">PIXEL SETUP</span>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">the trader's playbook</span>
      </div>

      <div className="mt-4">
        <SectionHeader title="Pixel Setup, step by step" subtitle="The conversion-pixel playbook a trader actually runs: create it, place it, set the windows, QA that it fires, then recover what the browser drops." />
      </div>

      {/* stepper chips */}
      <div className="mt-5 flex flex-wrap gap-1.5">
        {STEPS.map((s, i) => {
          const on = i === active
          const done = s.checklist.every((_, j) => checked[`${s.key}:${j}`])
          return (
            <button
              key={s.key}
              onClick={() => setActive(i)}
              aria-current={on ? 'step' : undefined}
              aria-label={`Step ${i + 1}: ${s.key}`}
              className={`flex items-center gap-1.5 rounded-full px-3 py-1.5 text-[12.5px] font-semibold transition-colors ${
                on ? 'bg-lime text-console' : 'bg-white/5 text-muted hover:text-ink'
              }`}
            >
              <span className={`font-mono ${on ? 'text-console/70' : 'text-white/35'}`}>{done ? '✓' : i + 1}</span>
              {s.key}
            </button>
          )
        })}
      </div>

      {/* active step */}
      <div className={`${card} mt-4`}>
        <div className="flex items-baseline justify-between gap-3">
          <h3 className="text-[15px] font-bold text-ink">{step.title}</h3>
          <span className="shrink-0 font-mono text-[10px] text-white/40">step {active + 1} of {STEPS.length}</span>
        </div>
        <p className="mt-2 text-[13px] leading-relaxed text-white/70">{step.blurb}</p>

        {step.code && (
          <pre className="mt-3 overflow-x-auto rounded-lg border border-white/10 p-3 font-mono text-[11.5px] leading-relaxed text-white/85" style={{ backgroundColor: 'rgba(0,0,0,0.35)' }}>
            <code>{step.code}</code>
          </pre>
        )}

        <div className="mt-3 flex flex-col gap-1.5">
          {step.checklist.map((item, i) => {
            const on = !!checked[`${step.key}:${i}`]
            return (
              <button key={i} onClick={() => toggle(i)} role="checkbox" aria-checked={on} aria-label={item} className="flex items-start gap-2.5 text-left">
                <span
                  className="mt-[2px] grid h-[16px] w-[16px] shrink-0 place-items-center rounded border text-[10px] font-bold"
                  style={{ borderColor: on ? C.lime : 'rgba(255,255,255,0.25)', backgroundColor: on ? C.lime : 'transparent', color: '#0e0e15' }}
                >
                  {on ? '✓' : ''}
                </span>
                <span className={`text-[12.5px] leading-snug ${on ? 'text-white/45 line-through' : 'text-white/75'}`}>{item}</span>
              </button>
            )
          })}
        </div>

        <div className="mt-4 flex gap-2">
          <button
            onClick={() => setActive((a) => Math.max(0, a - 1))}
            disabled={active === 0}
            className="rounded-full border border-white/15 px-4 py-1.5 text-[12.5px] font-semibold text-white/80 transition-colors hover:bg-white/5 disabled:opacity-30"
          >
            ← Prev
          </button>
          <button
            onClick={() => setActive((a) => Math.min(STEPS.length - 1, a + 1))}
            disabled={active === STEPS.length - 1}
            className="rounded-full bg-lime px-4 py-1.5 text-[12.5px] font-semibold text-console transition-transform active:scale-[0.98] disabled:opacity-30"
          >
            Next →
          </button>
        </div>
      </div>

      {/* calculators */}
      <div className="mt-5">
        <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">The numbers a trader checks</div>
        <div className="mt-3 grid grid-cols-1 gap-4 lg:grid-cols-3">
          <CaptureCalc />
          <DedupCalc />
          <DiscrepancyCalc />
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-lime/20 bg-lime/[0.05] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-lime">Why these are the numbers</div>
        <p className="mt-2 font-mono text-[12.5px] text-white/80">capture = client / back-end · reported = true · (1 + unmatched) · discrepancy = (reference − observed) / reference</p>
        <p className="mt-2 text-[12.5px] leading-relaxed text-white/55">
          A broken pixel does not just dent a dashboard — the bidder learns from conversions, so it optimizes toward the lie. These three checks (how much the client pixel captured, how much mismatched ids inflate the dedup, and whether a counting gap is normal drift) are the trader's standing QA. The dedup figure is an upper bound: it assumes both channels report every conversion. The full walkthrough, including Consent Mode v2, lives in the app's AdOps lessons.
        </p>
      </div>
    </section>
  )
}

function CalcCard({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div className={`${card} flex flex-col gap-3`}>
      <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">{title}</div>
      {children}
    </div>
  )
}

function NumberField({ label, value, onChange, min = 0, step = 1 }: { label: string; value: number; onChange: (v: number) => void; min?: number; step?: number }) {
  return (
    <label className="flex flex-col gap-1">
      <span className="text-[11px] text-white/55">{label}</span>
      <input
        type="number"
        value={value}
        min={min}
        step={step}
        onChange={(e) => {
          const n = Number(e.target.value)
          onChange(Number.isFinite(n) ? Math.max(min, n) : min)
        }}
        className="w-full rounded-lg border border-white/10 bg-white/[0.04] px-3 py-1.5 font-mono text-[13px] tabular-nums text-ink outline-none focus:border-white/30"
      />
    </label>
  )
}

function CaptureCalc() {
  const [client, setClient] = useState(920)
  const [backend, setBackend] = useState(1000)
  const cap = Tracking.captureRate(client, backend)
  return (
    <CalcCard title="Capture rate">
      <NumberField label="Pixel conversions" value={client} onChange={setClient} />
      <NumberField label="Back-end (true) conversions" value={backend} onChange={setBackend} min={1} />
      <div className="mt-1 flex flex-col gap-2 border-t border-white/10 pt-3">
        <StatRow label="Capture rate" value={pct(cap, 1)} color={cap >= 0.9 ? C.up : C.planning} />
        <StatRow label="Leaked to blockers / bounce" value={pct(Tracking.leakage(client, backend), 1)} color={C.down} />
      </div>
    </CalcCard>
  )
}

function DedupCalc() {
  const [trueN, setTrueN] = useState(1000)
  const [unmatched, setUnmatched] = useState(20)
  const reported = Tracking.dedupedTotal(trueN, unmatched / 100)
  return (
    <CalcCard title="Dedup inflation">
      <NumberField label="True conversions" value={trueN} onChange={setTrueN} min={1} step={10} />
      <Slider label="Event ids unmatched" value={unmatched} min={0} max={50} step={1} display={`${unmatched}%`} color={C.planning} onChange={setUnmatched} />
      <div className="mt-1 flex flex-col gap-2 border-t border-white/10 pt-3">
        <StatRow label="Reported after dedup" value={intc(reported)} color={unmatched > 0 ? C.down : C.up} />
        <StatRow label="Inflation over true" value={pct(Tracking.dedupInflation(unmatched / 100), 0)} color={unmatched > 0 ? C.down : C.up} />
      </div>
    </CalcCard>
  )
}

function DiscrepancyCalc() {
  const [reference, setReference] = useState(1_050_000)
  const [observed, setObserved] = useState(1_000_000)
  const d = Tracking.discrepancy(reference, observed)
  const ok = Tracking.withinNormalBand(d)
  return (
    <CalcCard title="Discrepancy QA">
      <NumberField label="Reference (publisher / back-end truth)" value={reference} onChange={setReference} min={1} step={1000} />
      <NumberField label="Observed (your pixel)" value={observed} onChange={setObserved} min={0} step={1000} />
      <div className="mt-1 flex flex-col gap-2 border-t border-white/10 pt-3">
        <StatRow label="Discrepancy vs reference" value={pct(d, 2)} color={ok ? C.up : C.down} />
        <div className="flex items-center justify-between">
          <span className="text-[12.5px] text-white/55">Verdict</span>
          <span className="rounded-full px-2 py-0.5 font-mono text-[11px] font-bold" style={{ backgroundColor: ok ? 'rgba(24,201,100,0.15)' : 'rgba(255,59,92,0.15)', color: ok ? C.up : C.down }}>
            {ok ? 'within ~10% band' : 'investigate'}
          </span>
        </div>
      </div>
    </CalcCard>
  )
}
