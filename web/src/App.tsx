import { TradingFloor } from './components/TradingFloor'

const REPO = 'https://github.com/scumunna/BidLab'
const RELEASES = 'https://github.com/scumunna/BidLab/releases'

export default function App() {
  return (
    <div className="mx-auto flex min-h-full max-w-5xl flex-col px-4 py-6 sm:px-6 sm:py-10">
      {/* header */}
      <header className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex flex-col gap-1.5">
          <div className="flex items-center gap-2.5">
            <span className="grid h-8 w-8 place-items-center rounded-lg bg-lime font-extrabold text-console">B</span>
            <span className="text-lg font-extrabold tracking-tight">BidLab</span>
            <span className="rounded-full border border-white/10 px-2 py-0.5 font-mono text-[10px] uppercase tracking-wide text-white/45">
              interactive demo
            </span>
          </div>
          <p className="max-w-xl text-[13.5px] text-white/55">
            The flight simulator for programmatic advertising. This is the hero <strong className="text-white/80">Trading Floor</strong>{' '}
            — the actual BidLab auction engine, running in your browser.
          </p>
        </div>
        <div className="flex shrink-0 gap-2">
          <a
            href={RELEASES}
            target="_blank"
            rel="noopener noreferrer"
            className="rounded-full bg-lime px-4 py-2 text-[13px] font-semibold text-console transition-transform active:scale-[0.98]"
          >
            Get the macOS app
          </a>
          <a
            href={REPO}
            target="_blank"
            rel="noopener noreferrer"
            className="rounded-full border border-white/15 px-4 py-2 text-[13px] font-semibold text-white/80 transition-colors hover:bg-white/5"
          >
            View on GitHub
          </a>
        </div>
      </header>

      <main className="mt-7">
        <TradingFloor />
      </main>

      {/* credibility footer */}
      <footer className="mt-8 border-t border-white/10 pt-6 text-[12.5px] leading-relaxed text-white/45">
        <p>
          <strong className="text-white/70">Why the numbers are real.</strong> This page runs a faithful TypeScript port of BidLab's
          pure Swift auction engine — the same log-normal market model, first/second-price clearing, publisher floors, and
          optimal-bid scoring as the native macOS app. The port is verified bit-for-bit against the Swift engine's seeded run in a
          golden-master test, so a given seed reproduces the native app's exact outcome.
        </p>
        <p className="mt-3">
          The full app adds 124 interactive lessons across 9 roles and 11 industry verticals, certification exams, spaced-repetition
          review, and shareable credentials.{' '}
          <a href={REPO} target="_blank" rel="noopener noreferrer" className="text-analytics underline-offset-2 hover:underline">
            See the project on GitHub →
          </a>
        </p>
      </footer>
    </div>
  )
}
