//
//  RSCollectionViewExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// UICollectionView-Extension
extension UICollectionView {
    
    /// UICollectionView注册Cell
    /// - Parameter cell: cell description
    public func rsRegisterWithCell(_ cell:UICollectionViewCell.Type){
        
        self.register(cell, forCellWithReuseIdentifier: UIView.rlViewIdentifier(cell))
    }
    
    /// UICollectionView注册HeaderView
    /// - Parameter viewType: viewType description
    public func rsRegistWithHeaderView(_ reusableViewType:UICollectionReusableView.Type){
        
        self.register(reusableViewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UIView.rlViewIdentifier(reusableViewType))
    }
    
    /// UICollectionView注册FooterView
    /// - Parameter viewType: viewType description
    public func rsRegistWithFooterView(_ reusableViewType:UICollectionReusableView.Type){
        
        self.register(reusableViewType, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UIView.rlViewIdentifier(reusableViewType))
    }
    
    /// UICollectionView-Dequeue-Cell
    /// - Parameters:
    /// - cellType:  cellType description
    /// - indexPath: indexPath description
    /// - Returns: description
    public func rsDequeueWithCell<T:UICollectionViewCell>(_ cellType:T.Type,for indexPath: IndexPath) -> T{
        
        return self.dequeueReusableCell(withReuseIdentifier: UIView.rlViewIdentifier(cellType), for: indexPath) as! T
    }

    /// UICollectionView-Dequeue-HeaderView
    /// - Parameters:
    ///   - cellType: cellType description
    ///   - indexPath: indexPath description
    /// - Returns: description
    public func rsDequeueWithHeaderView<T:UICollectionReusableView>(reuseIdentifier cellType: T.Type, for indexPath: IndexPath) -> T{
        
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: UIView.rlViewIdentifier(cellType), for: indexPath) as! T
    }
    
    /// UICollectionView-Dequeue-FotterView
    /// - Parameters:
    ///   - cellType: cellType description
    ///   - indexPath: indexPath description
    /// - Returns: description
    public func rsDequeueWithFooterView<T:UICollectionReusableView>(reuseIdentifier cellType: T.Type, for indexPath: IndexPath) -> T{
        
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: UIView.rlViewIdentifier(cellType), for: indexPath) as! T
    }
}
