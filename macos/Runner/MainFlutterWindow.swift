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

    // Keep original width calculation
    let minWidth: CGFloat = 1237.5  // Increased by 25% (990 * 1.25)

    // Use 100% of screen height
    let fullHeight = screenSize.height

    // Set minimum window size
    self.minSize = NSSize(width: minWidth, height: fullHeight)

    // Calculate optimal width (keep original logic) but use full height
    let optimalWidth = max(minWidth, min(windowFrame.size.width, screenSize.width * 1.0))

    // Set initial window size with full height
    let newFrame = NSRect(
      x: windowFrame.origin.x,
      y: screenFrame.origin.y,
      width: optimalWidth,
      height: fullHeight
    )
    self.setFrame(newFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
