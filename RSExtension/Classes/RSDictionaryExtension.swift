//
//  RSDictionaryExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import Foundation

/// Dictionary-Extension
extension Dictionary {
    
    /// Dictionary转换JSONString
    /// - Returns: JSONString
    public func rsDictionaryToJsonString() -> String {
        
        /// 判断是否是有效的JSON数据
        if (!JSONSerialization.isValidJSONObject(self)) { return "" }
        /// 开始数据的转换
        let rsSerializationData:NSData! = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData?
        let rsJSONString = NSString(data:rsSerializationData as Data,encoding: String.Encoding.utf8.rawValue)
        return rsJSONString! as String
    }
    
}


