import UIKit

class DemarteCore {

  class func colorFromHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
    let rComponent, gComponent, bComponent: CGFloat
    let offset = hexString.hasPrefix("#") ? 1 : 0
    let start = hexString.index(hexString.startIndex, offsetBy: offset)
    let hexColor = String(hexString[start...])
    let scanner = Scanner(string: hexColor)
    var hexNumber: UInt64 = .zero

    if scanner.scanHexInt64(&hexNumber) {
      rComponent = CGFloat((hexNumber & 0xff0000) >> 16) / 255
      gComponent = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
      bComponent = CGFloat(hexNumber & 0x0000ff) / 255
      return UIColor(red: rComponent, green: gComponent, blue: bComponent, alpha: alpha)
    }
    return UIColor(red: .zero, green: .zero, blue: .zero, alpha: alpha)
  }
}
