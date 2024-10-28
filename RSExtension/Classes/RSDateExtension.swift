//
//  RSDateExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import Foundation

/// 自定义时间格式
public enum RSDateFormat:String {
    
    /// 月-日
    case rs_md = "MM-dd"
    /// 年-月-日
    case rs_ymd = "yyyy-MM-dd"
    /// 年-月-日 时:分
    case rs_ymdhm = "yyyy-MM-dd HH:mm"
    /// 年-月-日 时:分:秒
    case rs_ymdhms = "yyyy-MM-dd HH:mm:ss"
    
}

/// Date-Extension
extension Date {

    /// 获取当前秒级时间戳 NOTE: 10位
    public var rsCurrentSecondTimeStamp : String {
        
        let rsTimeInterval: TimeInterval = self.timeIntervalSince1970
        let rsTimeStamp = Int(rsTimeInterval)
        return "\(rsTimeStamp)"
    }

    /// 获取当前毫秒级时间戳 NOTE: 13位
    public var rsCurrentMilliTimeStamp : String {
        
        let rsTimeInterval: TimeInterval = self.timeIntervalSince1970
        let rsTimeStamp = CLongLong(round(rsTimeInterval*1000))
        return "\(rsTimeStamp)"
    }
    
    /// 获取当前Date的固定RSDateFormat格式的字符串
    /// - Parameter rsDateFormat: rsDateFormat description
    /// - Returns: description
    public func rsDateToFormatString(_ rsDateFormat:RSDateFormat) -> String {
        
        let rsFormatter = DateFormatter()
        rsFormatter.dateFormat = rsDateFormat.rawValue
        return rsFormatter.string(from: self)
    }
    
}
