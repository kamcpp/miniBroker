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
    let minWidth: CGFloat = 950
    let minHeight: CGFloat = 700

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

    // Set up method channel for custom directory picker
    let channel = FlutterMethodChannel(
      name: "com.minibroker.directory_picker",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "pickDirectory" {
        self?.pickDirectory(arguments: call.arguments, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    super.awakeFromNib()
  }

  private func pickDirectory(arguments: Any?, result: @escaping FlutterResult) {
    let panel = NSOpenPanel()

    // Parse arguments
    if let args = arguments as? [String: Any] {
      if let title = args["title"] as? String {
        panel.title = title
      }
      if let initialDir = args["initialDirectory"] as? String {
        panel.directoryURL = URL(fileURLWithPath: initialDir)
      }
    }

    // Configure panel
    panel.canChooseFiles = false
    panel.canChooseDirectories = true
    panel.allowsMultipleSelection = false
    panel.canCreateDirectories = true  // Allow folder creation
    panel.showsHiddenFiles = true      // Show hidden files

    panel.begin { response in
      if response == .OK, let url = panel.url {
        result(url.path)
      } else {
        result(nil)
      }
    }
  }
}
