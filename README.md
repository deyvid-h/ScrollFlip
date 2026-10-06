# ScrollFlip

**Tired of your scroll direction flipping the wrong way every time you switch between your trackpad and a mouse?** Stop digging through System Settings. ScrollToggle fixes it with one click.

It's a tiny macOS menu bar app that turns **Natural scrolling** on and off instantly.

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
git clone https://github.com/deyvid-h/ScrollFlip.git
cd ScrollFlip
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
