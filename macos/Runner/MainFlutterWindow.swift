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
    let minWidth: CGFloat = 990
    
    // Use 100% height for smaller screens (13-inch), 90% for larger screens
    let heightRatio: CGFloat = screenSize.height <= 900 ? 1.0 : 0.9
    let minHeight: CGFloat = screenSize.height * heightRatio
    
    // Set minimum window size to ensure all content is visible
    self.minSize = NSSize(width: minWidth, height: minHeight)
    
    // Calculate optimal initial size
    let optimalWidth = max(minWidth, min(windowFrame.size.width, screenSize.width * 0.8))
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
