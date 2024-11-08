//
//  RSControllerExtension.swift
//  RSExtension
//
//  Created by gaoke on 8/11/2024.
//

import UIKit
import PKHUD
import Foundation
import Toast_Swift
import ProgressHUD

/// UIViewController-Extension
extension UIViewController {
    
    /// --------------------------------------------------------------------------------------------------------
    /// 展示PKHUD
    /// - Parameter rsHudContentType: rsHudContentType description
    public func rsShowPKHUD(_ rsHudContentType: HUDContentType = .progress){
        
        HUD.show(rsHudContentType, onView: self.view)
    }
    
    /// 展示PKHUD-延迟rsDelay自动隐藏
    /// - Parameters:
    ///   - rsHudContentType: rsHudContentType description
    ///   - rsDelay: rsDelay description
    ///   - rsCompletion: rsCompletion description
    public func rsShowPKHUD(_ rsHudContentType: HUDContentType, rsDelay: TimeInterval, rsCompletion: ((Bool) -> Void)? = nil) {
        
        HUD.show(rsHudContentType, onView: self.view)
        HUD.hide(afterDelay: rsDelay, completion: rsCompletion)
    }
    
    /// 展示成功PKHUD
    /// - Parameter rsCompletion: rsCompletion description
    public func rsShowSuccessPKHUD(_ rsCompletion:@escaping (() -> Void)){
        
        HUD.flash(.success,onView:self.view,delay: 1.5) { (compled) in
            if compled{
                rsCompletion()
            }
        }
    }
    
    /// 展示错误PKHUD
    /// - Parameter rsCompleted: rsCompleted description
    public func rsShowFailurePKHUD(rsCompleted:@escaping (() -> Void)){
        
        HUD.flash(.error,onView:self.view,delay: 1.5) { (compled) in
            if compled{
                rsCompleted()
            }
        }
    }
    
    /// 隐藏PKHUFD
    public func rsHiddenPKHUD(){
        
        HUD.hide()
    }
    
    /// --------------------------------------------------------------------------------------------------------
    ///
    ///
    public func rsShowBannerHUD(_ rsTitle:String, rsMessage:String,rsDelay:TimeInterval){
        
        /// 展示Banner提示
        ProgressHUD.banner(rsTitle, rsMessage, delay: rsDelay)
    }
    
    /// Description
    public func rsHiddenBannerHUD(){
        
        ProgressHUD.bannerHide()
    }
    
    
    /// --------------------------------------------------------------------------------------------------------
    /// 展示Show-Toast内容
    /// - Parameters:
    ///   - message:  展示的信息 - 为空不展示
    ///   - duration: 展示的时间 - 默认1.5秒钟
    ///   - position: 展示的位置 - 默认在View底部
    public func rsShowToast(_ message: String, duration: TimeInterval = 1.5, position: ToastPosition = .bottom) {
        
        if !message.isEmpty {
            self.view.makeToast(message, duration: duration, position: position)
        }
    }
    
}
