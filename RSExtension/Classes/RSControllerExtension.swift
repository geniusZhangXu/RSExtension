//
//  RSControllerExtension.swift
//  RSExtension
//
//  Created by gaoke on 8/11/2024.
//

import UIKit
//import PKHUD
import Foundation
import Toast_Swift
import ProgressHUD

/// UIViewController-Extension
extension UIViewController {
    
    /*
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
    }*/
    
    /// --------------------------------------------------------------------------------------------------------
    /// 
    /// - Parameters:
    ///   - rsTitle: rsTitle 顶部提示Banner标题
    ///   - rsMessage: 顶部提示Banner内容
    ///   - rsDelay: 顶部提示Banner展示时长-默认2秒
    public func rsShowBannerHUD(_ rsTitle:String, rsMessage:String,rsDelay:TimeInterval){
        
        /// 展示Banner提示
        ProgressHUD.banner(rsTitle, rsMessage, delay: rsDelay)
    }
    
    /// 这里只扩展了colorBanner，具体到字体颜色，Font等属性，也可以自行设计封装
    /// - Parameters:
    ///   - rsTitle: rsTitle description
    ///   - rsMessage: rsMessage description
    ///   - rsDelay: rsDelay description
    ///   - rsBannerBgColor: rsBannerBgColor description
    public func rsShowBannerHUD(_ rsTitle:String, rsMessage:String,rsDelay:TimeInterval,rsBannerBgColor:UIColor){
        
        ProgressHUD.colorBanner = rsBannerBgColor
        /// 展示Banner提示
        ProgressHUD.banner(rsTitle, rsMessage, delay: rsDelay)
    }
    
    /// Description
    public func rsHiddenBannerHUD(){
        
        ProgressHUD.bannerHide()
    }
    
    /// 展示加载动画
    /// - Parameters:
    ///   - rsTitle: rsTitle description
    ///   - rsAnimationType: rsAnimationType description
    public func rsShowAnimateHUD(_ rsTitle:String, rsAnimationType:AnimationType){
        
        ProgressHUD.animate(rsTitle,rsAnimationType)
    }
    
    /// 展示进度动画
    /// - Parameters:
    ///   - rsTitle: rsTitle description
    ///   - rsValue: rsValue Progress的值
    public func rsShowProgressHUD(_ rsTitle:String, rsValue:CGFloat){
        
        ProgressHUD.progress(rsTitle, rsValue)
    }
    
    /// Dismiss-ProgressHUD
    public func rsDismissHUD(){
        
        ProgressHUD.dismiss()
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
