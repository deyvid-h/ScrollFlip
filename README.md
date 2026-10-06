# ScrollToggle

A tiny macOS menu bar app that flips **Natural scrolling** on and off with one click. It's handy when you switch between a trackpad and a mouse.

- **Left-click** the menu bar icon to toggle.
- **Right-click** to see the current state or quit.

The icon shows a hand on a trackpad when natural scrolling is on, and a mouse when it's off.

## Requirements

- macOS 11 (Big Sur) or later
- Xcode Command Line Tools, which provide `swiftc`:

  ```bash
  xcode-select --install
  ```

## Install

```bash
git clone https://github.com/deyvid-h/ToggleTool.git
cd ToggleTool
bash build.sh
```

`build.sh` compiles the app, installs it to `/Applications/ScrollToggle.app`, and launches it. Look for the new icon in your menu bar.

## Launch at login (optional)

Go to **System Settings → General → Login Items** and add `ScrollToggle` from `/Applications`.

## Uninstall

Right-click the icon, choose **Quit ScrollToggle**, then run:

```bash
rm -rf /Applications/ScrollToggle.app
```
