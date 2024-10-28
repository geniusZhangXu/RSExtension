//
//  RSBundleExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import Foundation

/// Bundle-Extension
extension Bundle {
    
    /// 项目Bundle名称
    public var rsBundleName : String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    /// 项目展示的名称
    public var rsBundleDisplayName : String {
        return infoDictionary?["CFBundleDisplayName"] as! String
    }

    /// 项目的内部Build版本信息
    public var rsBundleBuildVersion : String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
    /// 项目的BundleIdentifier
    public var rsBundleIdentifier : String {
        return infoDictionary?["CFBundleIdentifier"] as! String
    }
    
    /// 外部展示的版本信息
    public var rsBundleVersion : String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }

}
