//
//  RSDeviceExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// UIDevice-Extension
extension UIDevice {
    
    /// 获取设备名称 - 设置里面自定义的名称
    public class func rsDeviceName() -> String {
        return UIDevice.current.name
    }
    
    /// 获取设备的型号 eg: @"iPhone", @"iPod touch"
    public class func rsDeviceModel() -> String {
        return UIDevice.current.model
    }
    
    /// 获取设备设置的地区码
    /// - Returns: description
    public class func rsDeviceRegionCode() -> String{
    
        if #available(iOS 16, *) {
            return Locale.current.region?.identifier ?? ""
        } else {
            return Locale.current.regionCode ?? ""
        }
    }
    
    /// 获取设备设置的语言码
    /// - Returns: description
    public class func rsLanguageCode() -> String{
    
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier ?? ""
        } else {
            return Locale.current.languageCode ?? ""
        }
    }
    
    /// 获取设备的系统版本
    public class func rsDeviceSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 获取设备的UUID
    public class func rsUUIDString() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }

    /// 判断设备是不是iPad
    /// - Returns: description
    public class func rsDeviceMatchedPad() -> Bool{
       let rliPadDevice = UIDevice.current.userInterfaceIdiom == .pad
       return rliPadDevice
    }

    /// 原始没有刘海的设备
    /// - Returns: description
    public class func rsDeviceMatchedOriginal() -> Bool{
        if self.rsDeviceSafeAreaBottomInsets() == 0.0 {
            return true
        }
       return false
    }
    
    /// 获取设备底部安全区域Insets-Bottom
    /// - Returns: description
    public class func rsDeviceSafeAreaBottomInsets() -> CGFloat {
        
        var rlBottomUnsafeHeight = 0.0
        if let rsAppDelegateWindow = UIApplication.shared.delegate?.window {
            if rsAppDelegateWindow?.safeAreaInsets.bottom ?? 0.0 > 0.0 {
                rlBottomUnsafeHeight = Double(rsAppDelegateWindow?.safeAreaInsets.bottom ?? 0.0)
            }
        }
        return rlBottomUnsafeHeight
    }
    
    /// 获取设备顶部安全区域Insets-Top
    /// - Returns: description
    public class func rsDeviceSafeAreaTopInsets() -> CGFloat {
        
        var rlTopUnsafeHeight = 0.0
        if let rsAppDelegateWindow = UIApplication.shared.delegate?.window {
            if rsAppDelegateWindow?.safeAreaInsets.top ?? 0.0 > 0.0 {
                rlTopUnsafeHeight = Double(rsAppDelegateWindow?.safeAreaInsets.top ?? 0.0)
            }
        }
        return rlTopUnsafeHeight
    }
    
    /// 获取设备的系统名称 eg: iPhone X,iPhone 14 Plus
    /// - Returns: description
    public class func rsDeviceSystemName() -> String{
        
        return UIDevice.current.rsDeviceSystemInfoName
    }
    
    /// 当前方法不公开
    private var rsDeviceSystemInfoName: String {
        ///
        var rsSystemInfo = utsname()
        uname(&rsSystemInfo)
        let rsMachineMirror = Mirror(reflecting: rsSystemInfo.machine)
        let rsIdentifier = rsMachineMirror.children.reduce("") { identifier, element in
            ///
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        /// iPad不做特殊处理
        if (rsIdentifier.contains("iPad")) { return "iPad" }
        switch rsIdentifier {
        // iPhone
        case "iPhone8,1":                        return "iPhone 6s"
        case "iPhone8,2":                        return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":           return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":           return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":         return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":         return "iPhone 8 Plus"
            
        case "iPhone10,3", "iPhone10,6":         return "iPhone X"
        case "iPhone11,8":                       return "iPhone XR"
        case "iPhone11,2":                       return "iPhone XS"
        case "iPhone11,4","iPhone11,6":          return "iPhone XS Max"
            
        case "iPhone12,1":                       return "iPhone 11"
        case "iPhone12,3":                       return "iPhone 11 Pro"
        case "iPhone12,5":                       return "iPhone 11 Pro Max"
        case "iPhone12,8":                       return "iPhone SE (2nd)"
            
        case "iPhone13,1":                       return "iPhone 12 mini"
        case "iPhone13,2":                       return "iPhone 12"
        case "iPhone13,3":                       return "iPhone 12 Pro"
        case "iPhone13,4":                       return "iPhone 12 Pro Max"
            
        case "iPhone14,2":                       return "iPhone 13 Pro"
        case "iPhone14,3":                       return "iPhone 13 Pro Max"
        case "iPhone14,4":                       return "iPhone 13 mini"
        case "iPhone14,5":                       return "iPhone 13"
        case "iPhone14,6":                       return "iPhone SE (3rd)"
        
        case "iPhone14,7":                       return "iPhone 14"
        case "iPhone14,8":                       return "iPhone 14 Plus"
        case "iPhone15,2":                       return "iPhone 14 Pro"
        case "iPhone15,3":                       return "iPhone 14 Pro Max"
        
        case "iPhone15,4":                       return "iPhone 15"
        case "iPhone16,1":                       return "iPhone 15 Pro"
        case "iPhone16,2":                       return "iPhone 15 Pro Max"
            
        case "iPhone17,3":                       return "iPhone 16"
        case "iPhone17,4":                       return "iPhone 16 Plus"
        case "iPhone17,1":                       return "iPhone 16 Pro"
        case "iPhone17,2":                       return "iPhone 16 Pro Max"
            
        ///iPhone模拟器
        case "i386","x86_64","arm64":            return "iPhone Simulator"
        default:
            return rsIdentifier
        }
    }
    
}


