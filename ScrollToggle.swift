// ScrollToggle — a tiny menu bar app that flips macOS "Natural scrolling".
// Left-click the icon to toggle. Right-click for a Quit menu.

import Cocoa

// Apple's own (undocumented) function that System Settings uses to apply the change instantly.
typealias SetFn = @convention(c) (Bool) -> Void
let framework = dlopen("/System/Library/PrivateFrameworks/PreferencePanesSupport.framework/PreferencePanesSupport", RTLD_NOW)
let setNaturalScrolling = unsafeBitCast(dlsym(framework, "setSwipeScrollDirection"), to: SetFn.self)

func isNaturalScrolling() -> Bool {
    CFPreferencesAppSynchronize(kCFPreferencesAnyApplication)
    let value = CFPreferencesCopyAppValue("com.apple.swipescrolldirection" as CFString,
                                          kCFPreferencesAnyApplication) as? Bool
    return value ?? true   // macOS default is natural scrolling ON
}

class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ notification: Notification) {
        guard let button = statusItem.button else { return }
        button.target = self
        button.action = #selector(clicked)
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        updateIcon(natural: isNaturalScrolling())
    }

    @objc func clicked() {
        if NSApp.currentEvent?.type == .rightMouseUp {
            let menu = NSMenu()
            let state = isNaturalScrolling() ? "Natural scrolling: ON (trackpad)" : "Natural scrolling: OFF (mouse)"
            menu.addItem(NSMenuItem(title: state, action: nil, keyEquivalent: ""))
            menu.addItem(.separator())
            menu.addItem(NSMenuItem(title: "Quit ScrollToggle",
                                    action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
            statusItem.menu = menu
            statusItem.button?.performClick(nil)   // show the menu
            statusItem.menu = nil                  // so left-click toggles again
        } else {
            let newValue = !isNaturalScrolling()
            setNaturalScrolling(newValue)
            updateIcon(natural: newValue)
        }
    }

    func updateIcon(natural: Bool) {
        guard let button = statusItem.button else { return }
        let symbol = natural ? "rectangle.and.hand.point.up.left" : "computermouse"
        if let image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil) {
            image.isTemplate = true   // adapts to light/dark menu bar
            button.image = image
            button.title = ""
        } else {
            button.image = nil
            button.title = natural ? "Pad" : "Mouse"
        }
        button.toolTip = natural ? "Natural scrolling ON — click to switch to mouse mode"
                                 : "Natural scrolling OFF — click to switch to trackpad mode"
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.accessory)   // menu bar only, no Dock icon
app.run()
