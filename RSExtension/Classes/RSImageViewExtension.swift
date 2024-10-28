//
//  RSImageViewExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Kingfisher
import Foundation

/// 图片压缩的范围
public enum RSImageCopmpress {
    
    /// 压缩到100KB(1024*100字节)以内
    case rs_oneLevel
    /// 压缩到200KB(1024*100字节)以内
    case rs_twoLevel
    /// 压缩到300KB(1024*100字节)以内
    case rs_threeLevel
}

extension UIImage{
    
    /// UIImage转Data
    /// - Returns: description
    public func rsImageToData() -> Data?{
        
        if let rsData = self.jpegData(compressionQuality: 1.0) {
            return rsData
        }else if let rsData = self.pngData() {
            return rsData
        }else{
            return nil
        }
    }
    
    /// 获取图片的存储的Size
    /// - Returns: description
    public func rsImageStoreSize() -> String {
    
        if let rsData = self.rsImageToData() {
            /// 将数据大小转换为MB
            let rsImageSize = String(format: "%.1f", Double(rsData.count) / 1024 / 1024)
            return rsImageSize + "MB"
        }
        return ""
    }
    
    /// 压缩图片-返回Data
    /// - Parameter rsCopmpress: 压缩的等级/最终范围
    /// - Returns: description
    public func rsCompressImageToData(_ rsCopmpress:RSImageCopmpress) -> Data{
        
        switch rsCopmpress {
        case .rs_oneLevel:
            return self.rsCompressImage(rsMaxSize: 1024*100)
        case .rs_twoLevel:
            return self.rsCompressImage(rsMaxSize: 1024*200)
        case .rs_threeLevel:
            return self.rsCompressImage(rsMaxSize: 1024*300)
        }
    }
    
    /// 压缩图片的方法
    /// - Parameter rsMaxSize: rsMaxSize description
    /// - Returns: description
    private func rsCompressImage(rsMaxSize: Int) -> Data {
        
        let tempMaxLength: Int = rsMaxSize
        var compression: CGFloat = 1
        
        guard var data = self.jpegData(compressionQuality: compression) else {
            return self.pngData() ?? Data.init()
        }
        if data.count <= tempMaxLength {
            return data
        }
        /// 压缩大小
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(tempMaxLength) * 0.9 {
                min = compression
            } else if data.count > tempMaxLength {
                max = compression
            } else {
                break
            }
        }
        var resultImage: UIImage = UIImage(data: data)!
        if data.count < tempMaxLength { return data }
        ///
        var lastDataLength: Int = 0
        while data.count > tempMaxLength && data.count != lastDataLength {
            
            lastDataLength = data.count
            let ratio: CGFloat = CGFloat(tempMaxLength) / CGFloat(data.count)
            print("Ratio =", ratio)
            let size: CGSize = CGSize(width: Int(resultImage.size.width * sqrt(ratio)),
                                      height: Int(resultImage.size.height * sqrt(ratio)))
            UIGraphicsBeginImageContext(size)
            resultImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            resultImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            data = resultImage.jpegData(compressionQuality: compression)!
        }
        return data
    }
    
    /// 裁剪区域内的图片
    /// - Parameter rsRect: rsRect description
    /// - Returns: description
    func rsClipImageWithRect(_ rsRect:CGRect) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(rsRect.size,false,UIScreen.main.scale)
        self.draw(in: rsRect)
        let rsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rsImage
    }
    
    /// Base 64 encoded PNG data of the image.
    /// - Returns: Base 64 encoded PNG data of the image as a String.
    func rsPngBase64String() -> String? {
        
        return self.pngData()?.base64EncodedString()
    }

    /// Base 64 encoded JPEG data of the image.
    /// - Parameter: compressionQuality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
    /// - Returns: Base 64 encoded JPEG data of the image as a String.
    func rsJpegBase64String(compressionQuality: CGFloat) -> String? {
        
        return self.jpegData(compressionQuality: compressionQuality)?.base64EncodedString()
    }
    
    
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
