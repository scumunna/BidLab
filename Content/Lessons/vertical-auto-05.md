---
id: vertical-auto-05
track: vertical-auto
module: 5
title: "Supply, Deals, and the Inventory Feed: PMP/Deal-ID, CTV, SPO, and Dynamic VLAs"
summary: Wire up where the ads run and how they stay tied to the lot, setting auto-endemic PMP and deal-IDs, trading CTV through private deals, running SPO to cut the tech tax, and keeping a Vehicle Listing Ads inventory feed healthy so net cost per sale stays low.
---
# From audience to activation: where the ad actually runs

Lesson 4 left you with a built audience. This lesson is the next move on the desk: deciding where those impressions are bought and how the creative stays glued to the live lot. In the Auto vertical the supply story is specific, you buy auto-endemic inventory (Cars.com, AutoTrader, CarGurus, Edmunds, plus Cox properties like KBB) where buyers are actively shopping vehicles, and you keep dynamic Vehicle Listing Ads in lockstep with what is physically on the dealer's lot. Get supply and feed right and the signature KPI, net cost per sale after co-op, drops because spend lands on in-market eyeballs against in-stock cars; get it wrong and you pay to send high-intent clicks to vehicles that already sold.

About 90% of display advertising is now transacted programmatically, which is exactly what gives a trader the levers in this lesson: private deals, supply-path control, and feed-driven dynamic creative all operate inside that programmatic pipe rather than around it.

:::figure supplyChain
caption: The supply path from the dealer's DSP to an auto-endemic publisher. Open auction is the long, hop-heavy route, a PMP or deal-ID is the negotiated private lane, and SPO prunes duplicate hops down to the cleanest path to that inventory.
:::

# Private deals: PMP, Preferred Deals, and Programmatic Guaranteed

Auto-endemic supply is rarely bought on the open auction. You set up a deal-ID in the DSP and transact through a Private Marketplace (PMP), a Preferred Deal, or Programmatic Guaranteed, because that route reaches buyers who are already on a vehicle-shopping page. Cox Automotive, for example, sells programmatic Preferred Deals across AutoTrader and KBB, and the deal-ID is the handshake that tells the DSP which negotiated inventory and price to bid on.

The three private-deal types differ on commitment. A PMP is an invite-only auction (you still bid, but only approved buyers compete), a Preferred Deal is a fixed-price first look before the open auction, and Programmatic Guaranteed is a reserved volume at a locked CPM with no auction at all. CTV, mobile apps, and other high-value inventory are increasingly traded through these private deals rather than open auction, which is how a Tier 3 trader gets a clean upper-funnel CTV consideration push next to the dealer's endemic display.

:::quiz
question: A dealer wants a reserved number of CTV impressions at a locked CPM with no auction. Which deal type fits?
- Open auction
- Private Marketplace (PMP)
- Preferred Deal
- Programmatic Guaranteed
answer: 3
hint: One of these removes the auction entirely and reserves fixed volume.
explain: Programmatic Guaranteed reserves a committed volume at a fixed CPM with no auction. A PMP is still an invite-only auction, a Preferred Deal is a fixed-price first look that you can decline (so volume is not guaranteed), and open auction is the opposite of reserved.
:::

# SPO: cutting hops and the tech tax

The same impression on an endemic publisher can be reachable through many supply paths, each adding an exchange fee and a layer of opacity. Supply-path optimization (SPO) is the trader's job of collapsing those duplicate hops down to the cleanest, most direct route, which cuts the tech tax (the cumulative cut taken by intermediaries) and raises the share of the dealer's dollar that reaches working media. You measure the prune with a simple ratio.

$$ \text{SPO hop reduction} = \frac{\text{original paths} - \text{retained paths}}{\text{original paths}} $$

The win is real money: trimming the tech tax means more of the budget becomes impressions, which lowers effective CPM and, downstream, net cost per sale. The risk is over-pruning, which the edge-cases section covers.

:::predict
prompt: Your DSP can reach a key AutoTrader impression through 8 supply paths. After SPO you keep 3. What percent of the paths did you cut?
answer: 62.5
tolerance: 0.5
unit: %
hint: Subtract retained from original, then divide by original.
explain: (8 - 3) / 8 = 5 / 8 = 0.625, so you cut 62.5 percent of the duplicate paths and route spend through the 3 cleanest hops to that inventory.
:::

:::predict
prompt: You spend $12,000 through an endemic deal. SPO cuts the blended tech tax from 22% to 15%. How many dollars of tech tax did you recover into working media?
answer: 840
tolerance: 1
unit: USD
hint: Apply the percentage-point drop to the spend.
explain: The tech tax falls 22% to 15%, a 7-point drop. 0.07 times $12,000 = $840 recovered from intermediaries into working media, which lowers effective CPM and net cost per sale.
:::

# The inventory feed and dynamic Vehicle Listing Ads

The signature activation skill in Auto is the inventory feed. You wire the dealer's live inventory into Google Merchant Center so dynamic Vehicle Listing Ads (VLAs) automatically render the exact in-stock vehicle, its price, and mileage, and link straight to that vehicle's VDP. Small, slow lots can upload a CSV or XML file; large, fast-changing lots use the Google Merchant API for real-time programmatic sync so the ad never advertises a car the lot no longer has (the older Content API for Shopping it replaced is sunsetting on August 18, 2026).

The feed is fragile by design. Google crawls each vehicle's landing page and compares the on-page price to the feed price, and any mismatch disapproves that listing, so only the VINs that pass become eligible to serve.

$$ \text{VLA eligible inventory} = \text{total VINs in feed} - \text{disapproved VINs} $$

:::predict
prompt: A 520-VIN feed has 65 vehicles disapproved for price and image mismatches. How many VINs are VLA-eligible?
answer: 455
tolerance: 0
unit: VINs
hint: Eligible equals total feed VINs minus the disapproved ones.
explain: 520 - 65 = 455 VLA-eligible VINs. The other 65 are silently dark until someone fixes the price or image mismatch in Merchant Center, so feed health is an ongoing operational duty, not a one-time setup.
:::

:::widget barChart
title: Where the auto buy is transacted (illustrative spend mix)
labels: Open Auction, PMP/Deal-ID, Preferred Deal, Programmatic Guaranteed, VLA Feed
data: 25, 35, 15, 10, 15
unit: %
:::

# Tying it back to net cost per sale

Supply and feed decisions are not academic; they move the only number the dealer principal cares about. Healthy endemic supply plus a clean feed sends in-market shoppers to in-stock cars, so VLA-driven cost per sale runs far below lead-portal supply (roughly $150 to $450 on VLAs versus $8,000 to $12,000 on AutoTrader and Cars.com listing products). And because co-op reimbursement typically halves your gross, the net figure you report is what survives the review.

$$ \text{Net cost per sale} = \frac{\text{media spend} - \text{co-op reimbursement}}{\text{VIN-matched units sold}} $$

:::predict
prompt: You run $9,000 through a VLA campaign on a clean feed, OEM co-op reimburses 50%, and VIN matchback credits 24 titled sales. What is the net cost per sale?
answer: 187.5
tolerance: 0.5
unit: USD
hint: Net the co-op out of spend first, then divide by VIN-matched units.
explain: Co-op covers 50% of $9,000, so net spend is $4,500. $4,500 / 24 = $187.50 net cost per sale, comfortably inside the $150 to $450 VLA band and an order of magnitude below the $8,000-plus lead-portal route.
:::

:::callout key
Supply and feed are buy-side levers on net cost per sale, not just plumbing. A PMP deal-ID points spend at active shoppers, SPO recovers tech tax into working media, and a clean feed turns clicks into in-stock-vehicle landings. Each one pushes the same KPI down, and you can attribute the move when you reference a yieldExplorer view of cost per working impression by supply path.
:::

# What breaks: feeds, disapprovals, and unauthorized VLAs

The failure modes here are operational and they hit silently. A stale feed keeps advertising a vehicle that already sold, so the best lead of the day clicks through to a dead VDP. Price-mismatch disapprovals cascade, one overnight pricing-tool run can disapprove dozens of VINs before anyone logs in at 9am, and over-aggressive SPO can prune the single path that was carrying a premium endemic PMP, quietly zeroing out delivery on that deal. Each of these shrinks eligible inventory or working media without throwing an obvious error, so the trader monitors feed health and delivery daily rather than waiting for sales to dip.

:::callout warning
A recurring operator complaint on DealerRefresh, captured in the thread titled "Why are third parties running Google VLA ads on MY vehicles? Shut it down!", is that third-party vendors run VLAs against a dealer's own VINs. The trader has to police Merchant Center for who else is bidding on the dealership's inventory, or competing listings cannibalize clicks the dealer is already paying co-op-eligible budget to win.
:::

:::quiz
question: At 9am the dealer reports VLA delivery collapsed overnight with no campaign change. What is the most likely cause to check first?
- The audience segment expired
- An overnight pricing-tool update disapproved a batch of VINs in Merchant Center
- The co-op reimbursement rate changed
- The attribution window was shortened
answer: 1
hint: Think about what runs unattended overnight and what the feed is checked against.
explain: An overnight pricing or inventory tool can push prices that no longer match the VDP, and Google disapproves every mismatched VIN, silently cutting eligible inventory and delivery. Audience expiry, co-op rates, and attribution windows do not collapse VLA delivery overnight the way a batch feed disapproval does.
:::

:::sources
- Autotrader B2B, Programmatic Preferred Deal (auto-endemic PMP and deal supply) | https://b2b.autotrader.com/oem/ad-solution/programmatic-preferred-deal-at/
- BuyerBridge, How to Setup Google Vehicle Listing Ads (VLAs) in 5 Steps | https://support.buyerbridge.com/knowledge/how-to-setup-google-vehicle-listing-ads
- DataFeedWatch, 6 Common Vehicle Ads Errors and How to Fix Them in Merchant Center | https://www.datafeedwatch.com/blog/google-vehicle-ads-errors
- Foundry CRO, Automotive Marketing Benchmarks 2026: CPC to Cost per Sale | https://foundrycro.com/blog/automotive-marketing-benchmarks-2026/
- Demand Local, How AI is Revolutionizing Attribution in Automotive Marketing | https://www.demandlocal.com/blog/ai-revolutionizing-attribution-automotive-marketing/
- DealerRefresh forum, Why are third parties running Google VLA ads on MY vehicles? Shut it down! | https://forum.dealerrefresh.com/threads/why-are-third-parties-running-google-vla-ads-on-my-vehicles-shut-it-down.9894/
:::
