# Farm Village Simulator

A pixel-art farm-life game where you wake up in your bedroom, walk out to a small farm, plant crops, raise animals, and slowly turn an empty plot of grass into a thriving homestead. Built with C++17 / SFML 2.6 / CMake.

---

## What you do

Each in-game day you have one job: make the farm a little bigger and a little richer than yesterday. That means:

- Plant seeds, water them, harvest the mature crops, sell what you don't cook.
- Buy plots of farmland as your Farming skill rises so you can plant more.
- Buy chickens, cows, sheep, and pigs as your Animal skill rises so they can produce eggs, milk, wool, and mushrooms for you to sell or cook.
- Sleep in the bed at the end of the day to advance time, then start over with crops grown, animals refreshed, and your skills a little higher.

Money is tight at the start (500g). You pay for seeds, plots, animals, and the greenhouse out of what you sell, so the loop is plant -> harvest -> sell -> invest.

---

## Controls

| Key | Action |
|-----|--------|
| WASD | Walk |
| Space | Use the currently selected tool / seed |
| X | Interact (sign, door, animal, plot, etc.) |
| 1 - 0, -, = | Pick a hotbar slot (12 slots total) |
| E | Open inventory (Esc also closes it) |
| Mouse left-click | Click a target tile to use the tool, or click a Yes / No popup button |
| Mouse wheel | Scroll in the shop / inventory |

Popups (greenhouse confirm, plot sign, animal sign, sleep) all accept both keyboard (Y/N) and mouse clicks on the Yes/No buttons.

---

## Daily loop

1. Wake up in bed - every new game day starts in the bedroom on the bed. Walk south through the door to step out to the farm porch.
2. Plant / water / harvest crops - face an owned plot tile, select seeds or the watering can on the hotbar, and press Space. Mature crops are harvested by pressing X on the tile (or by using the Shears in a forward cone).
3. Visit animals - walk into the chicken / cow / sheep / pig zones and use the right tool on each animal: Basket for chicken eggs and pig mushrooms, Bucket for cow milk, Shears for sheep wool. Each animal gives one item per day.
4. Sell at the shop - walk to the shop building, press X, and click items in the bottom inventory grid to sell one (Shift-click sells the whole stack). The "Sell All" button sells every crop, animal product, and cooked dish at once.
5. Buy more stuff - same shop UI: click a listing in the top scroll panel to buy. The shop shows in-season seeds first.
6. Sleep - walk back to the bed and press Y on the "Sleep until morning?" popup. Time skips to next morning, plots dry out, watered plots advance one growth stage, animals refresh, and a new wake-up popup appears.

---

## Hotbar layout (starting loadout)

| Slot | Item |
|------|------|
| 1 | Watering Can |
| 2 | Bucket (cow milk) |
| 3 | Basket (chicken eggs + pig mushrooms) |
| 4 | Shears (sheep wool + harvests mature crops in a forward cone) |
| 5 | Cabbage Seeds x 10 |
| 6-= | empty - fill them with seeds / produce you buy or harvest |

You start with **500 gold**. That's enough to buy ~12 extra cabbage seeds, or save for two days to afford a chicken (800g).

---

## Crops you can plant

Seeds carry a season tag. The shop sorts in-season seeds to the top and hides out-of-season seeds entirely. Greenhouse tiles bypass the season gate so you can plant anything inside an owned greenhouse year-round.

- Spring: Cabbage, Cauliflower, Carrot, Strawberry (regrow), Wheat, Onion
- Summer: Tomato (regrow), Hot Pepper, Corn (regrow), Watermelon, Cucumber (regrow), Pineapple, Dragon Fruit (regrow), Cherry (regrow)
- Fall: Pumpkin, Eggplant, Beet, Grape (regrow), Cotton

Each crop grows over several days. Water it every day or it won't tick - a dark overlay on the tile shows you've watered it today.

---

## Animals

Buy at the per-pen sign. Each kind roams inside its authored pasture zone and produces one item per day after the pen has water and hay.

| Animal | Price | Tool | Product | Sell value |
|--------|-------|------|---------|-----------|
| Chicken | 800g | Basket | Egg | 50g |
| Cow | 1500g | Bucket | Milk | 120g |
| Sheep | 4000g | Shears | Wool | 340g |
| Pig | ~4000g | Basket | Mushroom | 200g |

To buy more than the starting cap (2 chickens / 1 of each other), level the Animal skill. There's no slot-upgrade shop - pen size grows with skill. Animals stay in their pen because wander steps are clamped to the zone; if one ever ends up outside (zone redefinition, save migration) it auto-teleports back to the zone centre at the next sleep.

---

## Plots, greenhouses, and signs on the farm

- Plot sign at tile (6, 16) - opens "Buy farmland plot? - Plot N - Xg". Plot prices: 200g * (plot_index + 1).
- Animal signs at tile (44, 35) pig, (54, 36) chicken, (58, 43) cow, (69, 43) sheep - each opens a per-kind popup showing Owned / Cap and a Buy button.
- Greenhouses - walk up to a greenhouse footprint and press X. Up to 6 greenhouses, bought left-to-right at 5000g, 7500g, 10000g, 12500g, 15000g, 17500g. A walk-in greenhouse lets you plant any seed regardless of season.
- House door at tile (7, 9) - X enters; walking out drops you back on the porch at (7, 11).
- Shop building in the village - X enters the marketplace.
- Mine entrance in cell (2, 0) - venture into the mines to gather stone, ore, and combat XP.

---

## Tips for new players

- Day 1: plant your 10 cabbage seeds along an owned plot, water them all, sleep. You'll have ~200g extra by day 4 once they sell.
- Save up to 800g, then buy your first chicken at the chicken sign on the farm. One egg per day = passive income.
- The shovel is not required - you can plant seeds directly on grass. Tilling is purely cosmetic.
- Watered tiles get a dark overlay so you can see what's been watered today. Tiles dry to grass overnight if empty, or to brown dirt if a crop is on them.
- Buy plot 2 (400g) early - it doubles your planting capacity. By Farming level 2 you can own 9 plots; by L5 you can own 18.
- The cheapest greenhouse is 5000g but lets you grow off-season crops. Aim for it by the end of summer.

---

## Save files

Three save slots, picked from the title screen's "Continue" option. Saves include: gold, day/season/year, owned plots, owned greenhouses, animal counts, crops mid-growth in each tile, skill XP, shipping log, mail.
