extension NSObject {

  class func pluginDidLoad(bundle: NSBundle) {
    guard let appName = NSBundle.mainBundle().infoDictionary?["CFBundleName"] as? String
      where plugin == nil && appName == "Xcode" else {
        return
    }

    plugin = SocialCodingPlugin()
  }
}
