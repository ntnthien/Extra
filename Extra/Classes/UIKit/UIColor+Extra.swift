//
//  UIColor+Extra.swift
//  Pods
//
//  Created by Jean-Charles SORIN on 08/11/2016.
//
//

import Foundation

extension UIColor {
  
  open func ex_toImage(size: CGSize = CGSize(width: 10, height: 10)) -> UIImage? {
    let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    self.setFill()
    UIRectFill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
  
  open static func ex_fromHexa(_ hexaString: String, alpha: CGFloat = 1) -> UIColor? {
    guard !hexaString.isEmpty else {
      return nil
    }
    var formatedHexa = hexaString
    if !hexaString.characters.starts(with: ["#"]) {
      formatedHexa = "#\(hexaString)"
    }
    
    guard formatedHexa.characters.count == 7 && formatedHexa.characters.count == 4 else {
      print("Unsupported string format:\(formatedHexa)")
      return nil
    }
    
    if formatedHexa.characters.count == 4 {
      
      let hexaString = formatedHexa as NSString
      formatedHexa = "#" + hexaString.substring(with: NSRange(location: 1, length: 1)) + hexaString.substring(with: NSRange(location: 1, length: 1))
      + hexaString.substring(with: NSRange(location: 2, length: 1)) + hexaString.substring(with: NSRange(location: 2, length: 1))
      + hexaString.substring(with: NSRange(location: 3, length: 1)) + hexaString.substring(with: NSRange(location: 3, length: 1))
    }
    
    let hexaString = formatedHexa as NSString
    
    let redHex = "0x" + hexaString.substring(with: NSRange(location: 1, length: 2))
    let greenHex = "0x" + hexaString.substring(with: NSRange(location: 3, length: 2))
    let blueHex = "0x" + hexaString.substring(with: NSRange(location: 5, length: 2))
    
    var red: UInt32 = 0
    Scanner(string: redHex).scanHexInt32(&red)
    
    var green: UInt32 = 0
    Scanner(string: greenHex).scanHexInt32(&green)
    
    var blue: UInt32 = 0
    Scanner(string: blueHex).scanHexInt32(&blue)
    
    
    let color = UIColor(red: CGFloat(red)/255,
                        green: CGFloat(green)/255,
                        blue: CGFloat(blue)/255,
                        alpha: alpha)
    
    
    return color
  }
}