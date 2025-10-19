import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    
    // Get screen size to adapt to different monitors
    let screenSize = NSScreen.main?.visibleFrame.size ?? NSSize(width: 1440, height: 900)
    let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1440, height: 900)

    // Set reasonable minimum window size
    let minWidth: CGFloat = 800
    let minHeight: CGFloat = 600

    // Set minimum window size
    self.minSize = NSSize(width: minWidth, height: minHeight)

    // Start with minimum size
    let newFrame = NSRect(
      x: windowFrame.origin.x,
      y: windowFrame.origin.y,
      width: minWidth + 300,
      height: minHeight + 200
    )
    self.setFrame(newFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
