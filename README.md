# Farm Village Simulator

A farming simulator in C++17 + SFML 2.6. Built phase
by phase; see `docs/` for the design doc, the per-phase task log, the
wiki-comparison audit, and the sound-effect plan.

## What's playable

- **World**: 3×3 grid of 64×64 maps. Farm at (0, 1); the eight neighbours 
  are Bus Stop / Northern Forest / Mine Entrance / Village West / Village
  East / Bottom Forest / Beach / Beach East (broken bridge). Cross-map
  edges are 3-tile passages that preserve the player's position.
- **Farming**: 14 seasonal crops (wiki-faithful growth days + sell
  values + regrowth), watering, weeds, artifact spots, sprinklers.
- **Tools**: Hoe, Watering Can, Axe, Pickaxe, Scythe, Sword, Fishing Rod.
  Tier upgrades (Basic / Copper / Iron / Gold / Iridium) scale damage
  or AOE per the wiki.
- **Mining**: depth-scaled multi-floor mine, six ores, slimes.
- **Animals**: chickens (eggs) and cows (milk) in coop/barn buildings.
- **Machines**: Preserves Jar, Keg, Cheese Press, Mayonnaise Machine,
  Sprinkler — all craftable via the Crafting tab.
- **Village**: 18 NPCs, dialogue, friendship hearts. Five labelled shops
  + 4 community buildings (mayor's manor, theater, wizard's tower,
  Penny's trailer) + Community Center (5 bundles) + Help Wanted board.
- **Combat**: Sword with AOE, Slime monsters, player HP + i-frames.
- **Fishing**: vertical-bar minigame at any Water tile; spot-specific
  fish tables.
- **Crafting**: icon-grid tab with hover tooltips, ~12 recipes,
  Farming/Mining/Fishing skill gating.
- **Save**: three slots, yesterday-lag snapshot, deletion + previews.
- **Time / weather**: 6 AM → 2 AM day (~14 real minutes), four seasons,
  rain/storm/snow with auto-watering + lightning.

## Controls (wiki-aligned)

| Key | Action |
|---|---|
| WASD / arrows | Move |
| C | Use tool / item |
| X | Check — harvest, talk, interact |
| E | Inventory |
| F | Journal (routes to inventory for now) |
| M | Map (routes to inventory's Map tab) |
| LShift | Sprint |
| Tab | Cycle hotbar row (1 → 2 → 3) |
| 1 2 3 4 5 6 7 8 9 0 - = | Hotbar slots |
| Enter | Confirm in menus |
| Esc | Cancel / back |

`autoRun` is on by default; toggle in Settings if you want walking.

## Build & run (Windows + SFML 2.6)

```cmd
bash scripts/build.sh
./build/Release/farmvillage.exe
```

If you swap CMake config or hit weird link errors:

```cmd
rmdir /S /Q build
bash scripts/build.sh
```

`CMakeLists.txt` uses vcpkg-style SFML discovery; install SFML 2.6 via
vcpkg (`vcpkg install sfml`) and pass the toolchain file when running
CMake, or set `SFML_DIR` to your SFML CMake config folder.

## Project layout

```
src/
  core/         Settings, MathTypes, GameContext
  input/        Action enum + key bindings
  resources/    Font / texture cache
  ui/           HUD, TextDraw, theme
  items/        Item, Slot, Inventory
  entities/     Player, Crop catalogue, Slime, NPC, GroundItem
  tools/        Tool base + Hoe/Can/Axe/Pickaxe/Scythe/Sword/Rod
  world/        Map, Tile, Camera, Building, Machine, World
  systems/      TimeSystem, SaveManager, Skills, Shop, Quests,
                Bundles, Crafting
  scenes/       Title, CharacterCreation, World, Region, House/Shop/
                Mine interior, Day-end, Inventory, Pause, Dialogue,
                Fishing, QuestBoard, CommunityCenter, Travel
docs/
  wiki_audit.md     What matches the reference game wiki and what doesn't
  sfx_plan.md       Sound-effect plan (70+ SFX prioritised A/B/C)
  BUGS.md           Bug log
```

## Status

Latest milestone: **Phase 37** — collapse / 2 AM wake doesn't get
stuck on the bed-sleep prompt anymore.
