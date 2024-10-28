//
//  RSCollectionExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import Foundation

/// Collection-Extension
extension Collection {
    
    /// 下标安全访问集合,简称防爆-Collection是一个集合协[Array,Dictionary，Set]
    /// 数组使用：array[rsSafeIndex:13],越界时会返回nil
    /// example: let array = array[rsSafeIndex:10] 10代表你访问的下标
    public subscript (rsSafeIndex index: Self.Index) -> Iterator.Element? {
        
        (startIndex ..< endIndex).contains(index) ? self[index] : nil
    }
    
}
