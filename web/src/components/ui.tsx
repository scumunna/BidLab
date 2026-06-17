// Shared UI primitives + the brand palette (ported from Theme.swift), used by
// every explorable so they read as one product.

export const C = {
  lime: '#b6ff3a',
  up: '#18c964',
  down: '#ff3b5c',
  analytics: '#00b4d8',
  planning: '#ff9f1c',
  muted: '#9a9aa6',
  white: '#f4f4f8',
}

export const card = 'rounded-2xl border border-white/10 bg-white/[0.04] p-4'

export function Stat({ label, value, color = C.white }: { label: string; value: string; color?: string }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">{label}</span>
      <span className="font-mono text-[15px] font-bold tabular-nums" style={{ color }}>
        {value}
      </span>
    </div>
  )
}

export function StatRow({ label, value, color = C.white }: { label: string; value: string; color?: string }) {
  return (
    <div className="flex items-baseline justify-between">
      <span className="text-[12.5px] text-white/55">{label}</span>
      <span className="font-mono text-[13px] font-bold tabular-nums" style={{ color }}>
        {value}
      </span>
    </div>
  )
}

export function Slider({
  label,
  value,
  min,
  max,
  step,
  display,
  color,
  onChange,
}: {
  label: string
  value: number
  min: number
  max: number
  step: number
  display: string
  color: string
  onChange: (v: number) => void
}) {
  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-baseline justify-between">
        <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">{label}</span>
        <span className="font-mono text-[15px] font-bold tabular-nums" style={{ color }}>
          {display}
        </span>
      </div>
      <input
        type="range"
        min={min}
        max={max}
        step={step}
        value={value}
        onChange={(e) => onChange(Number(e.target.value))}
        style={{ ['--thumb' as string]: color }}
        aria-label={label}
        aria-valuetext={display}
      />
    </div>
  )
}

export function Segmented<T extends string | number>({
  options,
  value,
  onChange,
  ariaLabel,
}: {
  options: { label: string; value: T }[]
  value: T
  onChange: (v: T) => void
  ariaLabel: string
}) {
  return (
    <div role="tablist" aria-label={ariaLabel} className="flex gap-1 rounded-full bg-white/5 p-1">
      {options.map((o) => {
        const active = o.value === value
        return (
          <button
            key={String(o.value)}
            role="tab"
            aria-selected={active}
            onClick={() => onChange(o.value)}
            className={`flex-1 rounded-full px-3 py-1.5 text-[12.5px] font-semibold transition-colors ${
              active ? 'bg-white/15 text-ink' : 'text-muted hover:text-ink'
            }`}
          >
            {o.label}
          </button>
        )
      })}
    </div>
  )
}

export function Legend({ color, label }: { color: string; label: string }) {
  return (
    <span className="flex items-center gap-1.5">
      <span className="inline-block h-[7px] w-[7px] rounded-full" style={{ backgroundColor: color }} />
      <span className="font-mono text-[10px] text-white/55">{label}</span>
    </span>
  )
}

export function SectionHeader({ title, subtitle }: { title: string; subtitle: string }) {
  return (
    <div className="flex flex-col gap-1">
      <h2 className="text-2xl font-extrabold tracking-tight sm:text-3xl">{title}</h2>
      <p className="text-[13.5px] text-white/60">{subtitle}</p>
    </div>
  )
}
