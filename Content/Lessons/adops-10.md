---
id: adops-10
track: adops
module: 10
title: PMP and PG Deal Setup
summary: The four programmatic deal types, the Deal ID handshake from SSP to DSP, deal priority in the auction, floor interaction, and how to troubleshoot a PMP that is not spending.
---
# Four deal types, one bid request

Programmatic is not one marketplace, it is a stack of them, and a single bid request is offered to each in a fixed order of priority. Knowing that order is the whole foundation of deal setup, because it tells you which buyer wins when two of them want the same impression. From highest priority to lowest:

- Programmatic Guaranteed (PG): a one-to-one deal where the advertiser commits to a fixed volume of impressions at a fixed CPM, reserved before the flight. Revenue is guaranteed to the publisher and delivery is guaranteed to the buyer. Not an auction.
- Preferred Deal: a one-to-one, fixed-price deal that gives one buyer a first-look at inventory at a negotiated CPM, but with no obligation to buy. If they pass, the impression flows down to the next layer.
- Private Marketplace (PMP), also called a private auction: an invitation-only real-time auction among selected buyers, gated by a Deal ID, with a publisher-set floor. Auction-based, not reserved.
- Open Auction: the unreserved real-time bidding open to all buyers, lowest priority, highest fill, lowest average CPM.

The request is offered to PG first, then Preferred, then PMP, then the open auction, and it stops at the first layer that fills it.

:::quiz
question: A publisher has a PG deal, a PMP deal, and open auction demand all eligible for the same impression. In what order is the impression offered?
- Open auction, then PMP, then PG, because higher bids win
- PG, then Preferred, then PMP, then open auction
- PMP first, because private deals always beat guaranteed
- Whichever has the highest bid, regardless of deal type
answer: 1
hint: Reserved and guaranteed inventory is filled before anything that has to win an auction.
explain: The priority order runs Programmatic Guaranteed, then Preferred Deal, then PMP, then open auction. Guaranteed and reserved demand is satisfied first, and only the impressions left over flow down into the auction layers. Bid size only decides the winner within the auction layers, not across priority tiers.
:::

# Programmatic Guaranteed and locked revenue

PG is the programmatic version of a direct, reserved buy. The advertiser and publisher agree a fixed CPM and a fixed impression volume before launch, and that inventory is set aside. Because it is guaranteed on both sides, the publisher can book the revenue the moment the deal is signed, the same way a direct IO locks revenue. There is no auction and no bidding, the CPM is the CPM.

This is why PG sits at the top of the priority stack. A guaranteed impression has to be honored, so the ad server hands it to the PG deal before exposing it to any auction, even if an open-auction buyer would have paid more for it. The publisher trades potential auction upside for certainty of revenue and delivery.

$$ \text{PG revenue} = \frac{\text{guaranteed impressions}}{1000} \times \text{CPM} $$

:::predict
prompt: A publisher signs a Programmatic Guaranteed deal for 4,000,000 impressions at a 22.00 dollar CPM. How much revenue does the deal lock in, assuming full delivery?
answer: 88000
tolerance: 50
unit: $
hint: Divide impressions by 1000 to get the number of CPM units, then multiply by the CPM.
explain: 4,000,000 / 1000 = 4,000 thousand-impression units. At 22.00 dollars each that is 4,000 times 22.00 = 88,000 dollars. Because PG is guaranteed, the publisher books this revenue up front and the ad server prioritizes these impressions above the auction.
:::

:::callout key
PG is reserved and fixed-price, so it sits above every auction tier. The publisher gives up auction upside on those impressions in exchange for guaranteed revenue and the buyer's guaranteed delivery.
:::

# The Deal ID: SSP to DSP handshake

Every private deal, PG, Preferred, or PMP, is carried by a Deal ID. The Deal ID is an alphanumeric token created on the sell side and passed inside the bid request. When the same Deal ID is mapped on both the SSP and the DSP, the buyer's DSP recognizes the inventory as belonging to that deal and applies the deal's rules, its floor, its priority, its targeting, instead of treating the impression as plain open-auction supply.

The setup is a handshake. The publisher creates the deal on the SSP (selecting inventory, setting the floor, choosing the buyer or buyers, setting the deal type) and the SSP issues a Deal ID. The publisher sends that Deal ID to the buyer. The trader activates it in the DSP, attaches it to a line item or campaign, points the targeting at the Deal ID, and assigns approved creatives. Only once the ID is live on both ends and the bid request carries it does the deal transact.

Deals come in two shapes. A one-to-one deal binds a single seller to a single buyer on a single DSP, the classic private arrangement. A one-to-many deal (also called a platform or pre-negotiated deal) is still limited to one DSP, but any buyer on that DSP can transact against it.

:::figure supplyChain
caption: The Deal ID is minted on the SSP, handed to the buyer, and activated in the DSP. It rides inside the bid request so both sides recognize the same private deal.
:::

:::quiz
question: A trader pasted the Deal ID into the DSP but the line is not bidding. The publisher confirms the deal is live on the SSP and the floor is met. What is the most likely remaining setup gap?
- The Deal ID needs to be longer
- The line item targeting is not actually pointed at the Deal ID, or no approved creative is attached
- PMP deals cannot be activated in a DSP
- The open auction is blocking the deal
answer: 1
hint: Activating a Deal ID is not enough, the line has to target it and have something to serve.
explain: Putting a Deal ID into a DSP does nothing until a line item targets that Deal ID and has an approved creative of the right size and format attached. A common failure is the deal being mapped but the line targeting the wrong inventory, or the line having no eligible creative, so it never enters the deal's auction.
:::

# Floors, fees, and clearing the deal

A PMP or private auction has a floor, the minimum CPM a buyer must bid to be eligible. The buyer's typed bid is not what reaches that floor check, though. DSP and SSP fees are taken out along the way, so the bid that actually competes against the floor is lower than the number the trader entered. This is the single most common reason a deal does not clear: the buyer thinks they bid above the floor, but after fees their effective bid falls below it.

A practical rule from the sell side is that buyers should bid meaningfully above the quoted floor, often 25 to 30 percent higher, precisely because fees can erode a large share of the gross bid before it clears. Note also that most of programmatic, including Google Ad Manager since its 2019 to 2021 transition, now runs on a first-price auction, so the cleared price is the winning bid itself rather than a cent above the runner-up. Floor strategy in a first-price world is about pricing the inventory honestly, not gaming a second-price close.

$$ \text{effective bid} = \text{gross bid} \times (1 - \text{fee rate}) $$

:::predict
prompt: A trader bids a 8.00 dollar gross CPM into a PMP. Combined SSP and DSP fees take 20 percent before the bid reaches the auction. The deal floor is 7.00 dollars. Does the bid clear, and what is the effective bid?
answer: 6.4
tolerance: 0.05
unit: $
hint: Take 20 percent off the gross bid, then compare the result to the 7.00 dollar floor.
explain: The effective bid is 8.00 times (1 minus 0.20) = 8.00 times 0.80 = 6.40 dollars. The floor is 7.00 dollars, so 6.40 is below it and the bid does not clear. The trader has to raise the gross bid: to clear a 7.00 floor after a 20 percent fee they need at least 7.00 / 0.80 = 8.75 dollars gross.
:::

:::callout insight
Nine times out of ten a private deal with no spend is a floor problem. The buyer reads the floor as their target bid and forgets that fees come out first, so the effective bid lands under the floor and the deal never clears.
:::

# When priority beats a higher bid

The priority stack has a consequence traders find counterintuitive: a higher bid does not always win. Priority is resolved across tiers before price is compared within a tier. So a guaranteed deal at a modest CPM beats a PMP bid at a much higher CPM for the same impression, because the impression is handed to the PG layer before it ever reaches the PMP auction.

This is by design. Guaranteed inventory is a contractual commitment, the publisher owes those impressions, so the ad server fills them first regardless of what the auction would have paid. Price only decides the winner among buyers competing inside the same priority tier. A PMP buyer outbidding everyone in the private auction still loses any impression that a PG or Preferred deal claimed upstream.

:::predict
prompt: For one impression, a Programmatic Guaranteed deal is set at a 18.00 dollar CPM and a PMP buyer bids 25.00 dollars. Both are eligible. What CPM does the impression transact at, and who wins?
answer: 18
tolerance: 0.5
unit: $
hint: Decide the priority tier first, then the price. The PMP bid only matters if the impression reaches the PMP auction.
explain: PG sits above PMP in priority, so the impression is offered to the guaranteed deal first and transacts at its fixed 18.00 dollar CPM. The 25.00 dollar PMP bid never gets the chance to compete, because the impression is consumed by the higher-priority guaranteed deal before it reaches the private auction. Higher bid, lower priority, no win.
:::

# Troubleshooting a PMP that is not spending

A live Deal ID that delivers nothing is a routine AdOps fire. Work the causes in the order most likely to bite, fixing the first that applies and re-checking spend before moving on.

1. Floor versus effective bid. The most common cause. After SSP and DSP fees the effective bid is under the floor. Fix: raise the gross bid or ask the seller to lower the floor.
2. Deal not live or mismatched mapping. The deal is expired, paused, or the seat or Deal ID is mapped differently on the two sides. Fix: confirm the deal is active on the SSP and the Deal ID and seat match exactly in the DSP.
3. Targeting not pointed at the deal. The line item exists but does not actually target the Deal ID, or carries conflicting targeting that excludes the inventory. Fix: point the line at the Deal ID and clear conflicting filters.
4. No approved creative. The line has no creative, or the creative is the wrong size or format, or the seller blocked an unaudited or unknown-brand creative. Fix: attach an approved, correctly sized creative and clear brand declarations.
5. Buyer seat or domain blocked. Buyer seats default to blocking sellers until enabled, or a buyer domain allowlist excludes the deal's inventory. Fix: have the seller enable the buyer seat and audit the allowlist.
6. Priority loss inside the auction. The deal is bidding but losing to higher-priority deals or higher bids in the same tier. Fix: raise the bid or ask the seller to raise the deal's priority in the SSP.
7. Buy-side throttling. Frequency caps, pacing limits, or over-tight targeting are rate-limiting the bids. Fix: loosen caps and broaden targeting so the line can actually bid into the deal.

:::quiz
question: A PMP is mapped correctly, the deal is live, and the DSP shows a healthy bid rate but a near-zero win rate. Floor and creative are confirmed fine. What do you work first?
- Re-create the Deal ID from scratch
- Raise the bid or ask the seller to raise the deal's priority in the SSP
- Pause the open auction
- Lower the frequency cap to zero
answer: 1
hint: Bidding a lot but winning almost nothing points at price or priority inside the auction, not at setup.
explain: A healthy bid rate with a near-zero win rate means the line is entering the auction but losing it, so the problem is competitive, not configuration. Either the bid is too low to beat other demand or the deal is set at too low a priority in the SSP. Raise the bid or ask the seller to lift the deal's priority. Re-creating the Deal ID or touching the open auction would not address losing the private auction on price.
:::

:::sources
- Blockthrough, A publisher's guide to the 4 programmatic deal types | https://blockthrough.com/blog/guide-to-the-4-programmatic-deal-types/
- Gourmet Ads, Private Marketplace Deals and PMPs | https://www.gourmetads.com/programmatic/private-marketplace-deals/
- Gourmet Ads, Deal ID Debugging, 13 tips to get them to spend | https://www.gourmetads.com/articles/deal-id-debugging/
- Google Ad Manager Help, Private Auctions overview | https://support.google.com/admanager/answer/15708670?hl=en
- Google Ad Manager Help, Understand Private Auction troubleshooting | https://support.google.com/admanager/answer/6083218?hl=en
- Google, An update on first price auctions for Google Ad Manager | https://blog.google/products/admanager/update-first-price-auctions-google-ad-manager/
- Newor Media, Programmatic Guaranteed vs PMP, what's the difference | https://newormedia.com/blog/programmatic-guaranteed-vs-pmp/
- Digiday, Programmatic for sellers, understanding the world of programmatic deals | https://digiday.com/media-buying/programmatic-for-sellers-unit-2-understanding-the-world-of-programmatic-deals/
:::
