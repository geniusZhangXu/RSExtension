//
//  RSStringExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// String-Extension
extension String {
    
    /// String转CGFloat不能直接转需要Double中转
    /// - Returns: description
    public func rsFloatValue() -> CGFloat {
    
        let rsDoubleValue = Double(self)
        let rsFloatValue = CGFloat(rsDoubleValue ?? 0)
        return rsFloatValue
    }
    
    /// String进行UTF-8解码处理
    /// - Returns: description
    public func rsUtf8DecodedString()-> String {
        
        if let rsData = self.data(using: .utf8),let rsDecodedString = String(data: rsData, encoding: .nonLossyASCII){
            return rsDecodedString
        }
        return ""
    }
    
    /// String进行UTF-8编码处理
    /// - Returns: description
    public func rsUtf8EncodedString()-> String {
    
        if let rsData = self.data(using: .nonLossyASCII), let rsEncodedString = String(data: rsData, encoding: .utf8) {
            return rsEncodedString
        }
        return ""
    }
    
    /// 获取在最大宽度限制下文本高度
    /// - Parameters:
    ///   - rsTextMaxWidth: 最大限制宽度
    ///   - rsTextFont: 文本字体的大小
    /// - Returns: description
    public func rsTextHeight(rsTextMaxWidth:CGFloat,rsTextFont:UIFont) -> CGFloat {
        
        return NSString(string:self).boundingRect(with: CGSize(width: rsTextMaxWidth, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : rsTextFont], context: nil).height
    }
    
    /// 时间戳字符串转自定义DateFormat字符串
    /// - Parameter rsDateFormat: rsDateFormat description
    /// - Returns: description
    public func rsTimeStampToFormatString(rsDateFormat:RSDateFormat) -> String {
        
        let timeInterval:TimeInterval = TimeInterval.init(Double(self) ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rsDateFormat.rawValue
        let rsDate = Date(timeIntervalSince1970: timeInterval)
        return dateFormatter.string(from: rsDate)
    }
    
    /// 获取范围内的子字符串
    /// - Parameter rsRand: rsRand description
    /// - Returns: description
    public func rsSubStringInRange(_ rsRand: Range<Int>) -> String? {
        
        if rsRand.lowerBound < 0 || rsRand.upperBound > self.count { return nil }
        let endIndex = self.index(self.startIndex, offsetBy:rsRand.upperBound)
        let startIndex = self.index(self.startIndex, offsetBy:rsRand.lowerBound)
        return String(self[startIndex..<endIndex])
    }
    
    /// 截取特定长度的字符串
    /// - Parameter rsLegth: rsLegth description
    /// - Returns: description
    public func rsSubStringWithLength(_ rsLegth: Int) -> String? {
         
        if rsLegth >= self.count { 
            return self
        }else{
            return self.rsSubStringInRange((0..<rsLegth))
        }
    }
    
    /// 把自定义RSDateFormat时间格式字符串转为Date
    /// - Parameter rsDateFormat: rsDateFormat description
    /// - Returns: description
    public func rlStringToDate(rsDateFormat:RSDateFormat) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rsDateFormat.rawValue
        guard let rsDate = dateFormatter.date(from: self) else {
            return Date()
        }
        return rsDate
    }
    
    /// 把自定义RSDateFormat格式字符串转换为纽约时间时间戳
    /// - Parameter rlDateFormatEnum: rlDateFormatEnum description
    /// - Returns: description
    public func rsDateFormatStringToNewYorkTimeInterval(rsDateFormat:RSDateFormat) -> TimeInterval {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = rsDateFormat.rawValue
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")!
        guard let rsDate = dateFormatter.date(from: self) else { return 0}
        return rsDate.timeIntervalSince1970
    }
    
}

/// NSMutableAttributedString-Extension
extension NSMutableAttributedString {
    
    /// 设置当前整个富文本的行间距+返回自身NSMutableAttributedString
    /// - Parameter rsAllLineSpace: rsAllLineSpace description
    /// - Returns: description
    public func rsTextSpace(rsAllLineSpace:CGFloat) -> NSMutableAttributedString {

        let nsMutableParagraphStyle = NSMutableParagraphStyle.init()
        nsMutableParagraphStyle.lineSpacing = rsAllLineSpace
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: nsMutableParagraphStyle, range: NSMakeRange(0, self.length))
        return self
    }
    
    /// 设置AttributedString段落样式
    /// - Parameters:
    ///   - rsLineSpacing: rsLineSpacing 行间距
    ///   - rsAlignment: rsAlignment 对齐方式
    public func rsAttributedStringParagraphStyle(rsLineSpacing: CGFloat? = nil, rsAlignment: NSTextAlignment? = nil){
        
        let nsMutableParagraphStyle = NSMutableParagraphStyle()
        if let lineSpacing = rsLineSpacing {
            nsMutableParagraphStyle.lineSpacing = lineSpacing
        }
        if let alignment = rsAlignment {
            nsMutableParagraphStyle.alignment = alignment
        }
        self.addAttributes([NSAttributedString.Key.paragraphStyle : nsMutableParagraphStyle], range: NSRange(location: 0, length: self.length))
    }
    
    /// AttributedString-拼接字符串
    /// - Parameter rsString: rsString description
    public func rsAppendString(_ rsString: String) {
        self.append(NSAttributedString(string: rsString))
    }
    
    /// AttributedString-拼接字符串+颜色
    /// - Parameters:
    ///   - rsString: rsString description
    ///   - rsColor: rsColor description
    public func rsAppendString(_ rsString: String, rsColor: UIColor) {
        self.append(NSAttributedString(string: rsString, attributes: [NSAttributedString.Key.foregroundColor : rsColor]))
    }
    
    /// AttributedString-拼接字符串+颜色+常规字体Font
    /// - Parameters:
    ///   - rsString: rsString description
    ///   - rsColor: rsColor description
    ///   - rsSystemFontSize: rsSystemFontSize description
    public func rsAppendString(_ rsString: String, rsColor: UIColor, rsSystemFontSize:CGFloat){
        self.append(NSAttributedString(string: rsString, attributes: [NSAttributedString.Key.foregroundColor : rsColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: rsSystemFontSize)]))
    }
    
    /// AttributedString-拼接字符串+颜色+粗体字体Font
    /// - Parameters:
    ///   - rsString: rsString description
    ///   - rsColor: rsColor description
    ///   - rsBoldFontSize: rsBoldFontSize description
    public func rlAppendString(_ rsString: String, rsColor: UIColor, rsBoldFontSize:CGFloat) {
        self.append(NSAttributedString(string: rsString, attributes: [NSAttributedString.Key.foregroundColor : rsColor, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: rsBoldFontSize)]))
    }
}
