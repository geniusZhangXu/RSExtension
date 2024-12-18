//
//  RSDataExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// Data-Extension
extension Data{
    
    /// Data的大小
    public func rsDataSize() -> String {
        
        let rsSizeCount = self.count
        let rsDataKbSize = rsSizeCount / 1024
        if rsDataKbSize < 1024 {
            return "\(rsDataKbSize)" + "KB"
        }else{
            let rsDataMbSize = rsDataKbSize / 1024
            return "\(rsDataMbSize)" + "MB"
        }
    }
    
    /// Data转Image输出
    /// - Returns: description
    public func rsDataToImage() -> UIImage? {
        
        if let rsImage = UIImage(data: self, scale: 1) {
            return rsImage
        } else {
            return nil
        }
    }
    
    /// Data转Dictionary输出
    /// - Returns: description
    public func rsDataToDictionary() ->Dictionary<String, Any>?{
        
        do{
            let rsJsonObject = try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
            let rsDictionary = rsJsonObject as! Dictionary<String, Any>
            return rsDictionary
        }catch _ {
            /// 转化失败输出
            debugPrint("[RS]: Data To Dictionary Error")
            return nil
        }
    }
}
