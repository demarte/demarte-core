import UIKit

class DemarteCore {

  /// Allows you to convert a 6 digit hexadecimal string into a UIColor instance
  /// - Warming: The "#" symbol is stripped from the beginning of the string submitted here.
  /// - Parameters:
  ///   - hexString: A 6-digit hexadecimal string. Use 6 digits rather than 8, and add
  ///   the accompanying alpha value in the second parameter
  ///   - alpha: A number between 0.0 and 1.0 indicating how transparent the color is
  /// - Returns: A UIColor defined by the `hexString` parameter
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
