---
id: foundations-09
track: foundations
module: 9
title: Counting and Combinatorics
summary: The multiplication principle, permutations versus combinations, why creative by audience by placement combinations explode, frequency distributions of exposures, and counting the paths through a campaign.
---
# The multiplication principle

Counting sounds trivial until the numbers get large, and in advertising they get large fast. The foundation is the multiplication principle, sometimes called the fundamental counting principle. If one choice can be made in $a$ ways and a second, independent choice in $b$ ways, then the two choices together can be made in $a \times b$ ways. Extend it to any number of stages, multiply the count at each stage, and you have the total.

The word independent matters. Each stage's options do not depend on what you picked at the earlier stage. Building one ad means picking a creative, then an audience, then a placement, and the placements available do not change based on which creative you chose, so you multiply. This single rule is the engine behind almost every counting question you will hit, and it is why ad operations problems balloon so quickly.

$$ N = n_1 \times n_2 \times \cdots \times n_k $$

:::predict
prompt: You build one ad by choosing 1 of 3 creatives, then 1 of 4 audiences, then 1 of 5 placements. How many distinct ad combinations are possible?
answer: 60
tolerance: 0
unit: 
hint: Multiply the number of choices at each of the three stages.
explain: By the multiplication principle, $3 \times 4 \times 5 = 60$ distinct combinations. Each creative can pair with each audience, and each of those pairs with each placement, so the counts multiply rather than add.
:::

# Permutations, when order matters

Sometimes you are arranging things and the order of the arrangement matters. A permutation is an ordered arrangement. The number of ways to arrange $r$ items chosen from $n$ distinct items is $P(n, r) = \frac{n!}{(n-r)!}$, where the factorial $n!$ means $n \times (n-1) \times \cdots \times 1$. For example $5! = 5 \times 4 \times 3 \times 2 \times 1 = 120$.

Order matters when, say, you sequence three ads into the first, second, and third slot of a video pod, or decide the order creatives rotate to a user. Picking creatives A then B then C is a different sequence from C then B then A, so both get counted. With 5 creatives filling 3 ordered slots you have $P(5, 3) = 5 \times 4 \times 3 = 60$ arrangements, because the first slot has 5 options, the second has 4 left, and the third has 3 left.

$$ P(n, r) = \frac{n!}{(n-r)!} $$

:::predict
prompt: You have 5 creatives and 3 ordered slots in a video ad pod, where slot order matters. How many distinct ordered arrangements are there?
answer: 60
tolerance: 0
unit: 
hint: The first slot has 5 options, the second has 4 remaining, the third has 3 remaining. Multiply them.
explain: $P(5,3) = 5 \times 4 \times 3 = 60$. After placing a creative in the first slot only 4 remain for the second, then 3 for the third, so you multiply the shrinking counts. Order matters here, which is why this is a permutation.
:::

# Combinations, when order does not matter

Often order is irrelevant. If you are choosing a set of creatives to test together, the group of A, B, and C is the same group as C, B, and A, so you should count it once. A combination is an unordered selection. The count is $C(n, r) = \frac{n!}{r!(n-r)!}$, which is the permutation count divided by $r!$ to remove the duplicate orderings of the same group.

Compare the two on the same numbers. Choosing 3 creatives from 5 as an ordered sequence gives $P(5,3) = 60$, but as an unordered set it gives $C(5,3) = \frac{120}{6 \times 2} = 10$. The combination is smaller by a factor of $3! = 6$, the number of ways to reorder any group of three. The single question to ask yourself every time is whether reordering the same items creates a genuinely new outcome. If yes, permutation. If no, combination.

$$ C(n, r) = \frac{n!}{r! \, (n-r)!} $$

:::quiz
question: You want to pick 2 publishers from a shortlist of 8 to run a test, and the order you pick them in does not matter. How many possible pairs are there?
- 28
- 16
- 64
- 56
answer: 0
hint: Order does not matter, so this is a combination. Use $C(8,2) = \frac{8 \times 7}{2}$.
explain: $C(8,2) = \frac{8!}{2! \, 6!} = \frac{8 \times 7}{2 \times 1} = 28$. If order had mattered it would be $P(8,2) = 56$, but a pair is the same pair regardless of which one you name first, so you divide by $2! = 2$ to get 28.
:::

# Why combinations explode

Here is where the multiplication principle turns into a real operational problem. Modern campaigns are assembled from modular parts, and the total number of buildable ads is the product of the parts. Take 5 audiences, 4 creative formats, and 3 copy variations. That is $5 \times 4 \times 3 = 60$ distinct ads to build, launch, monitor, and optimize, and that is a small example. Display creative pipelines are worse. With 5 templates, 10 fonts, 20 colors, and 20 image sizes you can composite $5 \times 10 \times 20 \times 20 = 20{,}000$ candidate creatives.

This is combinatorial explosion. Adding one more option to any single stage multiplies the whole total, it does not just add to it, so the count grows far faster than intuition expects. A 10-audience by 4-format by 6-copy matrix is already $10 \times 4 \times 6 = 240$ ads, and at roughly five minutes of manual setup each that is 20 hours of pure build work. Understanding the multiplication is what tells you to prune the matrix, automate the assembly, or test elements separately rather than every full combination.

:::widget barChart
title: Buildable ad combinations grow multiplicatively as you add options (illustrative)
labels: 3x4x5, 5x4x3, 10x4x6, 5x10x20x20
data: 60, 60, 240, 20000
unit: 
:::

:::predict
prompt: A display tool composites creatives from 5 templates, 10 fonts, 20 text colors, and 20 image sizes, each chosen independently. How many candidate creatives can it produce?
answer: 20000
tolerance: 0
unit: 
hint: Multiply all four counts together using the multiplication principle.
explain: $5 \times 10 \times 20 \times 20 = 20{,}000$ candidate creatives. Each independent stage multiplies the running total, so four modest menus combine into twenty thousand possibilities. This is why creative pipelines test components rather than every full combination.
:::

# Frequency distributions of exposures

Counting also describes how often people see your ads. Average frequency is a single number, total impressions divided by the unique people reached, but it hides the real story. The frequency distribution is the full picture, a table or histogram showing how many people saw the ad once, how many saw it 2 to 3 times, 4 to 6 times, 7 or more times, and so on. Reach reporting commonly buckets users at thresholds like 1+, 2+, 3+, 5+, and 10+ exposures.

Two campaigns with the same average frequency can have very different distributions. One might spread exposures evenly so most people land near the average, while another piles many exposures on a small group and barely touches everyone else. That heavy tail is wasteful overexposure, the case for a frequency cap. So you compute the average to size the campaign, then read the distribution to find the overexposed tail. The average is the headline, the distribution is the truth.

$$ \text{average frequency} = \frac{\text{total impressions}}{\text{unique people reached}} $$

:::predict
prompt: A campaign serves 3,000,000 impressions and reaches 1,200,000 unique people. What is the average frequency?
answer: 2.5
tolerance: 0.01
unit: 
hint: Divide total impressions by the number of unique people reached.
explain: $3{,}000{,}000 \div 1{,}200{,}000 = 2.5$ impressions per person on average. That single number sizes the campaign, but you still need the full frequency distribution to see whether a small group was hit 10 or more times while many were reached only once.
:::

# Counting the paths through a campaign

The last use of counting is mapping out everything that can happen, the paths through a campaign. A conversion path is a sequence of touchpoints, and the number of possible sequences is again a multiplication. If a user can be touched by any of 4 channels at each of 3 stages of the funnel, there are $4 \times 4 \times 4 = 4^3 = 64$ possible ordered channel paths. Each branch of choices multiplies the count of routes from start to finish.

Counting paths is how you size an attribution problem, lay out a test matrix, or estimate how many distinct journeys your reporting must account for. The recurring lesson across this whole module is that advertising structures are built by multiplying independent choices, so counts grow multiplicatively and reach large numbers quickly. Knowing whether order matters, whether you are arranging or selecting, and how the stages multiply is what keeps those large numbers under control.

:::quiz
question: A user can be touched by any of 4 channels at each of 3 funnel stages, and order matters since a channel can repeat. How many possible ordered channel paths are there?
- 12
- 24
- 64
- 81
answer: 2
hint: Each of the 3 stages independently has 4 channel options, so multiply 4 by itself 3 times.
explain: Each stage has 4 independent choices, so the total is $4 \times 4 \times 4 = 4^3 = 64$ ordered paths. Repetition is allowed because the same channel can appear at more than one stage, which is why it is $4^3$ and not $P(4,3) = 24$.
:::

:::sources
- Cuemath, Permutations and combinations | https://www.cuemath.com/data/permutations-and-combinations/
- Math is Fun, Combinations and permutations | https://www.mathsisfun.com/combinatorics/combinations-permutations.html
- Khan Academy, Counting permutations and combinations | https://www.khanacademy.org/math/statistics-probability/counting-permutations-and-combinations
- AdStellar, Meta advertising campaign complexity | https://www.adstellar.ai/blog/meta-advertising-campaign-complexity
- arXiv, Cross-element combinatorial selection for multi-element creative in display advertising | https://arxiv.org/pdf/2307.01593
- Wikipedia, Frequency (marketing) | https://en.wikipedia.org/wiki/Frequency_(marketing)
- AppsFlyer, Creative testing strategies | https://www.appsflyer.com/blog/measurement-analytics/creative-testing/
- Count.co, Ad frequency analysis | https://count.co/metric/ad-frequency-analysis
:::
