# coverglub

A minimal, floating album art widget for Linux that displays your currently playing music with elegant hover controls.

## Features

- 🎨 **Clean album art display** - Shows cover art from any MPRIS-compatible media player
- 🎮 **Hover controls** - Previous, play/pause, next buttons appear on hover with smooth animations
- 📐 **Resizable** - Right-click to cycle between 200px, 350px, and 500px sizes
- 🪟 **Always floating** - Stays on top, perfect for tiling window managers
- 🔄 **Works with any player** - Supports Spotify, YouTube Music, VLC, or any MPRIS-compatible player

## Requirements

- Python 3
- GTK4
- playerctl
- A media player with MPRIS support (Spotify, YouTube Music, VLC, etc.)

## Installation

### NixOS / Nix

The script includes a nix-shell shebang, so you can run it directly:

```bash
chmod +x coverglub
./coverglub
```

### Other distros

Install dependencies:

**Arch Linux:**
```bash
sudo pacman -S python-gobject gtk4 playerctl
```

**Ubuntu/Debian:**
```bash
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-4.0 playerctl
```

**Fedora:**
```bash
sudo dnf install python3-gobject gtk4 playerctl
```

Then run:
```bash
chmod +x coverglub
./coverglub
```

## Usage

- **Left-click + drag** - Move the widget around
- **Hover** - Show controls and song info
- **Right-click** - Cycle window size (200px → 350px → 500px)
- **Click buttons** - Previous, play/pause, next track

## Configuration

Edit the constants at the top of the script to customize:

```python
WINDOW_SIZES = [200, 350, 500]  # Available window sizes
CORNER_RADIUS = 20              # Rounded corner radius
CONTROL_SPACING = 20            # Space between control buttons
OVERLAY_COLOR = (0, 0, 0, 0.75) # Dark overlay color (R, G, B, Alpha)
POLL_INTERVAL_MS = 2000         # How often to check for song changes
```

## Customizing for different players

By default, the script targets Spotify. To use with other players, edit the `playerctl` function:

```python
# For YouTube Music:
def playerctl(*args):
    return run(["playerctl", "-p", "youtube-music", *args])

# For any active player (auto-detect):
def playerctl(*args):
    return run(["playerctl", *args])
```

## Known Issues

- **Niri compositor**: The widget appears in alt+tab (Niri doesn't support window type hints for exclusion yet)
- **Wayland compositors**: Some compositors may not respect the floating/utility window hints

## License

MIT
