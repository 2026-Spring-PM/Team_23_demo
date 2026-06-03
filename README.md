# Farm Village Simulator Demo

This is a peer-feedback demo package for Team 23's pixel farm-life game.

This repository intentionally does not include the source code. It contains only the files needed to run the demo and collect feedback.

## Package Contents

```text
farmvillage   # Linux x86_64 executable
assets/       # required images, maps, UI, and font assets
Dockerfile    # Docker runtime setup, especially useful for macOS users
run.sh        # local launcher script
README.md     # game overview and run instructions
```

## What Kind of Game Is This?

Farm Village Simulator is a 2D pixel-art farming game inspired by farm-life games. You wake up in your house, walk around the farm, plant and water crops, raise animals, buy upgrades, and sleep to advance to the next day.

The main gameplay loop is:

1. Plant seeds on owned farm plots.
2. Water crops each day so they grow.
3. Harvest crops when mature.
4. Collect animal products such as eggs, milk, wool, and mushrooms.
5. Sell products at the shop.
6. Use earned gold to buy more seeds, animals, farm plots, and greenhouse upgrades.
7. Sleep in the house to start the next day.

Starting gold is limited, so the demo is mostly about testing the core farming, animal, shop, UI, and map interaction flow.

## Controls

| Key / Input | Action |
|---|---|
| WASD | Move |
| Space | Use selected tool or seed |
| X | Interact with doors, signs, animals, plots, and objects |
| E | Open inventory |
| 1 to 0, -, = | Select hotbar slot |
| Mouse left-click | Click UI buttons or target tiles |
| Mouse wheel | Scroll shop / inventory |
| Y / N | Confirm or cancel popup choices |
| Esc | Close menu / go back |

## Run Directly on Linux / WSL

Open a terminal in this repository folder and run:

```bash
chmod +x ./farmvillage ./run.sh
./run.sh
```

You can also run the executable directly:

```bash
./farmvillage
```

Important: run it from this repository folder because the executable loads files from `assets/` using relative paths.

## Run with Docker on macOS

The executable is a Linux x86_64 SFML program. On macOS, run it through Docker Desktop and XQuartz.

1. Install Docker Desktop for Mac.
2. Install XQuartz from https://www.xquartz.org/.
3. Open XQuartz.
4. In XQuartz, open `XQuartz > Settings > Security` and enable `Allow connections from network clients`.
5. Restart XQuartz.
6. In macOS Terminal, move to this repository folder.
7. Build the Docker image:

```bash
docker build --platform linux/amd64 -t team23-demo .
```

8. Allow Docker to connect to XQuartz:

```bash
xhost + 127.0.0.1
```

9. Run the game:

```bash
docker run --rm -it \
  --platform linux/amd64 \
  -e DISPLAY=host.docker.internal:0 \
  team23-demo
```

If the game window does not appear, check these first:

- XQuartz is running.
- `Allow connections from network clients` is enabled.
- XQuartz was restarted after changing the setting.
- You ran `xhost + 127.0.0.1` before `docker run`.

## Run with Docker on WSLg / Linux

Build the image:

```bash
docker build -t team23-demo .
```

For WSLg:

```bash
docker run --rm -it \
  -e DISPLAY=$DISPLAY \
  -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
  -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /mnt/wslg:/mnt/wslg \
  team23-demo
```

For a normal Linux X11 desktop:

```bash
xhost +local:docker
docker run --rm -it \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  team23-demo
```

## What To Test

Please give feedback on:

- Whether the game launches correctly.
- Whether the title screen, UI, font, and inventory are readable.
- Whether movement feels natural.
- Whether collision works around fences, buildings, water, and animal areas.
- Whether house, shop, barn, coop, and greenhouse interactions are understandable.
- Whether planting, watering, harvesting, and selling are clear.
- Whether animal product collection is understandable.
- Any crash, freeze, missing image, or broken interaction.

## Notes

This is a demo build for feedback, not a final release. The balance, UI, map layout, and interactions may still change.