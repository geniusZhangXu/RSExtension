//
//  RSColorExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// UIColor-Extension
extension UIColor {
 
    /// 自定义几个常见的颜色值
    /// HEX-333333
    public class var rsColor3: UIColor {
        return UIColor(rsHexValue: "333333")
    }

    /// HEX-666666
    public class var rsColor6: UIColor {
        return UIColor(rsHexValue: "666666")
    }
    
    /// HEX-999999
    public class var rsColor9: UIColor {
        return UIColor(rsHexValue: "999999")
    }
    
    /// 黑色-颜色透明度为50%
    public class var rsColorBlack05: UIColor {
        return UIColor(rsHexValue: "000000",rsAlpha:0.5)
    }
    
    /// 白色-透明度50%
    public class var rsColorWhite05: UIColor {
        return UIColor(rsHexValue: "FFFFFF",rsAlpha:0.5)
    }
    
    
    
}

extension UIColor {
    
    /// 使用Hex值便利构造UIColor
    /// - Parameters:
    ///   - rsHexValue: HEX值
    ///   - rsAlpha: 颜色透明度
    convenience init(rsHexValue: String, rsAlpha:CGFloat = 1.0) {
        
        var rValue: UInt64 = 0x0
        var gValue: UInt64 = 0x0
        var bValue: UInt64 = 0x0
        
        var cString: String = rsHexValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 {
            self.init(red: CGFloat(rValue)/255.0,green: CGFloat(gValue)/255.0,blue: CGFloat(bValue)/255.0, alpha: rsAlpha)
            return
        }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 {
            self.init(red: CGFloat(rValue)/255.0,green: CGFloat(gValue)/255.0,blue: CGFloat(bValue)/255.0,alpha: rsAlpha)
            return
        }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        Scanner(string: rString).scanHexInt64(&rValue)
        Scanner(string: gString).scanHexInt64(&gValue)
        Scanner(string: bString).scanHexInt64(&bValue)
        
        self.init(red: CGFloat(rValue)/255.0,green: CGFloat(gValue)/255.0,blue: CGFloat(bValue)/255.0,alpha: rsAlpha)
    }
    
}

