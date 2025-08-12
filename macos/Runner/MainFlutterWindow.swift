import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    
    // Set minimum window size to ensure all content is visible without scrolling
    self.minSize = NSSize(width: 990, height: 800) // Increased width by 10% (900 -> 990)
    
    // Set initial window size if current size is too small
    if windowFrame.size.height < 1000 || windowFrame.size.width < 990 {
      let newFrame = NSRect(
        x: windowFrame.origin.x,
        y: windowFrame.origin.y,
        width: max(windowFrame.size.width, 990), // Increased width by 10%
        height: max(windowFrame.size.height, 1000)
      )
      self.setFrame(newFrame, display: true)
    } else {
      self.setFrame(windowFrame, display: true)
    }

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
