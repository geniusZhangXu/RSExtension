//
//  RSImageViewExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Kingfisher
import Foundation

extension UIImageView{
    
   
    
}

/// UICollectionView-Extension - 设置图片的地址
extension UIImageView {
    
    /// 根据网络地址设置图片
    /// - Parameters:
    ///   - rsImageUrlString: rsImageUrlString description
    ///   - rsPlaceholderImage: rsPlaceholderImage description
    public func rsSetImageWithUrl(_ rsImageUrlString: String?,_ rsPlaceholderImage:String? = "", options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil,completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        
        ///
        guard let urlString = rsImageUrlString else {
            self.image = UIImage(named: rsPlaceholderImage!)
            return
        }
        /// URL图片地址不能为空
        if !urlString.isEmpty {
            self.imageViewSetImage(with: URL(string: urlString),placeholder:UIImage(named: rsPlaceholderImage!),options: options,progressBlock: progressBlock,completionHandler: completionHandler)
        }else{
            self.image = UIImage(named: rsPlaceholderImage!)
        }
    }
    
    ///
    /// - Parameters:
    ///   - resource: resource description
    ///   - placeholder:   placeholder description
    ///   - options:       options description
    ///   - progressBlock: progressBlock description
    ///   - completionHandler: completionHandler description
    private func imageViewSetImage(with resource: Resource?, placeholder: Placeholder? = nil, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil,completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        
         _ = kf.setImage(with: resource, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }
    
}
