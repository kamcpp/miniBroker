import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    
    // Get screen size to adapt to different monitors
    let screenSize = NSScreen.main?.visibleFrame.size ?? NSSize(width: 1440, height: 900)
    
    // Calculate responsive window size based on screen size
    let minWidth: CGFloat = 1237.5  // Increased by 25% (990 * 1.25)

    // Use 107% height for smaller screens (13-inch), 96.3% for larger screens (90% * 1.07)
    let heightRatio: CGFloat = screenSize.height <= 900 ? 1.07 : 0.963
    let minHeight: CGFloat = screenSize.height * heightRatio

    // Set minimum window size to ensure all content is visible
    self.minSize = NSSize(width: minWidth, height: minHeight)

    // Calculate optimal initial size - increased width by 25% and height by 7%
    let optimalWidth = max(minWidth, min(windowFrame.size.width, screenSize.width * 1.0))  // Increased from 0.8 to 1.0 (25% increase)
    let optimalHeight = max(minHeight, min(windowFrame.size.height, screenSize.height * heightRatio))
    
    // Set initial window size
    let newFrame = NSRect(
      x: windowFrame.origin.x,
      y: windowFrame.origin.y,
      width: optimalWidth,
      height: optimalHeight
    )
    self.setFrame(newFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
