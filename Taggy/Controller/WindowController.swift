import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let window = window {
            window.setFrame(NSRect(x: 0, y: 0, width: 1200, height: 700), display: true)
            window.center()
        }
    }

}
