---
id: sales-01
track: sales
module: 1
title: The sell side and the deal
summary: Who buys what on the sell side, how managed service differs from self-serve, and how a deal moves from pitch to live delivery.
---
# Two sides of the same impression

Every programmatic transaction has a buy side and a sell side. The buy side is the advertiser and its tools, the demand-side platform (DSP) that bids on impressions. The sell side is the publisher and its supply-side platform (SSP), the technology that packages inventory and exposes it to buyers.

As a sales or account person on the sell side, you sit between a publisher with inventory to sell and a buyer with a budget to spend. Your job is to turn raw ad opportunities into revenue, at the highest sustainable price, without leaving inventory unsold.

:::predict
prompt: A publisher has 2,000,000 ad opportunities in a day and sells them for $9,000 in total revenue. What effective CPM did the sell side realize across all opportunities?
answer: 4.5
unit: $
tolerance: 0.05
hint: Effective CPM is total revenue divided by impressions, times 1000.
explain: eCPM = $9,000 / 2,000,000 x 1000 = $4.50. Leaving opportunities unsold pulls this number down, which is why the sell side packages inventory into deals to lift the realized price.
:::

# Who buys what

Buyers come in layers. A brand wants outcomes. Its agency plans and executes the media. A trading desk operates the DSP and decides which exchanges and publishers to bid into. Knowing which layer you are talking to tells you what they care about: a brand wants reach and results, a trading desk wants efficient supply paths and clean inventory.

What they buy is also layered. The open exchange is the spot market, anyone can bid. Above it sit deals: private marketplaces, preferred deals, and guaranteed buys that give specific buyers priority access to specific inventory at agreed terms. Premium inventory rarely sells on the open market alone.

:::callout insight
The sell side does not sell impressions one at a time. It sells access, in packages and deals, to buyers who value some inventory more than others.
:::

:::widget barChart
title: Typical CPM by deal type (illustrative)
labels: PG, PMP, Open
data: 18, 12, 4
unit: $
:::

# Managed service vs self-serve

Two operating models exist for putting a campaign live. In managed service, your team runs the campaign: setup, targeting, optimization, and reporting all happen in-house on the client's behalf. The client outsources the complexity and pays for the expertise. In self-serve, the buyer logs into the platform and runs everything themselves, paying mainly for access to the technology.

Managed service carries higher touch and higher margin per account but does not scale without headcount. Self-serve scales cleanly but compresses margin and demands a product good enough to use unattended. Most platforms run a blend, managed service for large or new accounts, self-serve for sophisticated buyers who want control.

:::callout key
Managed service trades labor for margin and control. Self-serve trades margin for scale. The right mix depends on account size and buyer sophistication.
:::

:::predict
prompt: A managed-service account bills $50,000 in media but the team's service labor costs $20,000 to run it. What is the margin on revenue for this account?
answer: 60
unit: %
hint: Margin on revenue is (revenue minus cost) divided by revenue, times 100.
explain: Margin = ($50,000 - $20,000) / $50,000 x 100 = 60%. Managed service earns a high margin per account, but that $20,000 of labor does not shrink as you add accounts, which is why the model does not scale without headcount.
:::

# The deal flow

A deal moves through a predictable path. It starts with a pitch and a brief, moves to a proposal with inventory and pricing, then to a negotiated insertion order or deal terms. Once agreed, ad ops configures the deal in the ad server and the SSP issues a deal ID, a unique string a DSP uses to bid against that package.

From there the campaign goes live, paces against its flight, and gets monitored and optimized until it delivers in full. Billing reconciles delivered impressions against agreed terms. Each stage is a handoff between sales, account management, and ad ops, so clean communication is what keeps a deal from stalling.

:::widget codeLab
:::

:::quiz
question: What is the main tradeoff between managed service and self-serve models?
- Managed service earns higher margin per account but does not scale without headcount
- Self-serve always produces higher revenue than managed service
- Managed service is only used for open-exchange buys
- Self-serve requires no advertising technology
answer: 0
explain: Managed service is high-touch and high-margin but labor-bound, while self-serve scales on technology at the cost of thinner per-account margin.
:::

:::sources
- Managed Service vs. Self-Service Programmatic Platforms, Setupad | https://setupad.com/blog/managed-services-vs-self-service-programmatic-platforms/
- Programmatic Deals 101, BidSwitch | https://blog.bidswitch.com/programmatic-deals-101-what-every-marketer-needs-to-know
:::
