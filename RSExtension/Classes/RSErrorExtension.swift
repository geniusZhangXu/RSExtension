//
//  RSErrorExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import Foundation

/// Error-Extension
extension Error {
    
    /// 处理Error的Code
    public var rsErrorCode:Int? {
        
        return (self as NSError).code
    }
    
}


