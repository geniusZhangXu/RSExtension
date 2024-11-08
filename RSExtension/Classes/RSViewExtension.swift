//
//  RSViewExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import PKHUD
import Foundation
import Toast_Swift

/// 给UIView添加手势
public typealias RSViewGestureAction = (UIGestureRecognizer)->()

///  自定义手势类型
public enum RSGestureRecognizer {
    
    case rs_panGesture      /// 拖拽手势
    case rs_tapGesture      /// 点击手势
    case rs_longGesture     /// 长按手势
    case rs_swipeGesture    /// 轻扫手势
    case rs_pinchGesture    /// 捏合缩放
    case rs_roationGesture  /// 旋转手势
}

/// 自定义手势的Key
private struct RSGestureActionKeys {

    static var rlPanActionKey:Void?
    static var rlTapActionKey:Void?
    static var rlLongActionKey:Void?
    static var rlSwipeActionKey:Void?
    static var rlPinchActionKey:Void?
    static var rlRoationActionKey:Void?
}

/// View-Frame
extension UIView {
    
    /// Point-X
    public var x:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue;
            self.frame = frame
        }
    }
    
    /// Point-Y
    public var y:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    /// View-centerX
    public var centerX:CGFloat{
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    /// View-centerY
    public var centerY:CGFloat{
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    /// View-origin
    public var origin:CGPoint{
        get{
            return self.frame.origin
        }
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    /// View-size
    public var size:CGSize{
        get{
            return self.frame.size
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    /// View-width
    public var width:CGFloat{
        get{
            return self.frame.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    /// View-height
    public var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /// View-bottom
    public var bottom:CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }    
}

///
extension UIView{
    
    /// 获取View的名称
    /// - Returns: description
    public class func rsViewClassCoder() -> String {
        
        return NSStringFromClass(self.classForCoder())
    }
    
    /// 给View根据自己项目的BundleId设置标记
    /// - Parameter viewType: viewType description
    /// - Returns: description
    public class func rlViewIdentifier<T:UIView>(_ viewType: T.Type) -> String {
        
        let rsViewClassCoder = viewType.rsViewClassCoder()
        var rsBundleIdentifier = Bundle.main.rsBundleIdentifier
        rsBundleIdentifier = rsBundleIdentifier + "."
        return rsViewClassCoder.replacingOccurrences(of: rsBundleIdentifier, with: "")
    }
    
    /// View设置从上到下颜色渐变的背景
    /// - Parameters:
    ///   - rsFrame: rsFrame description
    ///   - rsTopColor: 上部的颜色
    ///   - rsBottomColor: 底部的颜色
    public func rsSetGradientBackground(rsFrame:CGRect,rsTopColor: UIColor, rsBottomColor: UIColor) {
        
        let rsGradientLayer = CAGradientLayer()
        rsGradientLayer.frame = rsFrame
        rsGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        rsGradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        rsGradientLayer.colors = [rsTopColor.cgColor, rsBottomColor.cgColor]
        self.layer.insertSublayer(rsGradientLayer, at: 0)
    }
    
    /// View设置不规则圆角
    /// - Parameters:
    ///   - rsRectCorner: rsRectCorner description
    ///   - rsRadius: 圆角的大小
    public func rsSetRoundCorners(rsRectCorner: UIRectCorner, rsRadius: CGFloat) {
        
        let rsBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rsRectCorner, cornerRadii: CGSize(width: rsRadius, height: rsRadius))
        let rsShapeLayer = CAShapeLayer()
        rsShapeLayer.path = rsBezierPath.cgPath
        self.layer.mask = rsShapeLayer
    }
    
    /// View转换成UIImage输出
    /// - Returns: description
    public func rsViewTransformToImage() -> UIImage? {
        
        let size = self.bounds.size
        /// 第一个参数表示区域大小。
        /// 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传false，否则传true。
        /// 第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(size,false,UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let rsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rsImage
    }
    
}

extension UIView{
    
    /// 以下是利用Runtime添加手势回调属性
    /// View的点击事件行为
    @objc dynamic var rsViewTapAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlTapActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlTapActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }
    
    /// View的长按事件行为
    @objc dynamic var rsViewLongAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlLongActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlLongActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }
    
    /// View的移动事件行为
    @objc dynamic var rsViewPanAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlPanActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlPanActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }
    
    /// View的缩放事件行为
    @objc dynamic var rsViewRoationAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlRoationActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlRoationActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }

    /// View的轻扫事件行为
    @objc dynamic var rsViewSwipeAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlSwipeActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlSwipeActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }
    
    /// View的捏合事件行为
    @objc dynamic var rsViewPinchAction:RSViewGestureAction? {
        
        set{
            objc_setAssociatedObject(self, &RSGestureActionKeys.rlTapActionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let rlViewAction = objc_getAssociatedObject(self, &RSGestureActionKeys.rlTapActionKey) as? RSViewGestureAction {
                return rlViewAction
            }
            return nil
        }
    }
    
    /// 点击事件
    /// - Parameter gesture: gesture description
    @objc func viewTapAction(gesture: UIGestureRecognizer) {
        
        if let rsViewTapAction = self.rsViewTapAction{
            rsViewTapAction(gesture)
        }
    }
    
    /// 长按事件
    /// - Parameter gesture: gesture description
    @objc func viewLongAction(gesture: UIGestureRecognizer) {
        
        if let rsViewLongAction = self.rsViewLongAction {
            rsViewLongAction(gesture)
        }
    }
    
    /// 拖拽事件
    /// - Parameter gesture: gesture description
    @objc func viewPanAction(gesture: UIGestureRecognizer) {
        
        if let rsViewPanAction = self.rsViewPanAction{
            rsViewPanAction(gesture)
        }
    }
    
    /// 旋转事件
    /// - Parameter gesture: gesture description
    @objc func viewRoationAction(gesture: UIGestureRecognizer) {
        
        if let rsViewRoationAction = self.rsViewRoationAction{
            rsViewRoationAction(gesture)
        }
    }
    
    /// 轻扫事件
    /// - Parameter gesture: gesture description
    @objc func viewSwipeAction(gesture: UIGestureRecognizer) {
        
        if let rsViewSwipeAction = self.rsViewSwipeAction{
            rsViewSwipeAction(gesture)
        }
    }
    
    /// 捏合事件
    /// - Parameter gesture: gesture description
    @objc func viewPinchAction(gesture: UIGestureRecognizer) {
        
        if let rsViewPinchAction = self.rsViewPinchAction{
            rsViewPinchAction(gesture)
        }
    }
    
    /// NOTE: 使用的时候注意循环引用的问题 在{}in数据前面添加[weak self]使用
    /// - Parameters:
    ///   - rsGesture: rsGesture description
    ///   - rsResponse: rsResponse description
    public func rsAddGestureRecognizer( _ rsGesture : RSGestureRecognizer, rsResponse: @escaping RSViewGestureAction) {
        
        self.isUserInteractionEnabled = true
        switch rsGesture {
            /// 点击事件
            case .rs_tapGesture:
            let rsTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapAction(gesture:)))
            rsTapGesture.numberOfTapsRequired = 1
            rsTapGesture.numberOfTouchesRequired = 1
            self.addGestureRecognizer(rsTapGesture)
            self.rsViewTapAction = rsResponse
            /// 长按事件
            case .rs_longGesture:
            let rsLongPress = UILongPressGestureRecognizer(target: self, action: #selector(viewLongAction(gesture:)))
            self.addGestureRecognizer(rsLongPress)
            self.rsViewLongAction = rsResponse
            /// 拖拽事件
            case .rs_panGesture:
            let rsPanGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanAction(gesture:)))
            self.addGestureRecognizer(rsPanGesture)
            self.rsViewPanAction = rsResponse
            /// 旋转事件
            case .rs_roationGesture:
            let rsRoation = UIRotationGestureRecognizer(target: self, action: #selector(viewRoationAction(gesture:)))
            self.addGestureRecognizer(rsRoation)
            self.rsViewRoationAction = rsResponse
            /// 轻扫事件
            case .rs_swipeGesture:
            let rsSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipeAction(gesture:)))
            self.addGestureRecognizer(rsSwipe)
            self.rsViewSwipeAction = rsResponse
            /// 捏合事件
            case .rs_pinchGesture:
            let rsPinch = UIPinchGestureRecognizer(target: self, action: #selector(viewPinchAction(gesture:)))
            self.addGestureRecognizer(rsPinch)
            self.rsViewPinchAction = rsResponse
        }
    }
    
}

/// UIView-Extension
extension UIView {
    
    /// --------------------------------------------------------------------------------------------------------
    /// 展示PKHUD
    /// - Parameter rsHudContentType: rsHudContentType description
    public func rsShowPKHUD(_ rsHudContentType: HUDContentType = .progress){
        
        HUD.show(rsHudContentType, onView: self)
    }
    
    /// 展示PKHUD-延迟rsDelay自动隐藏
    /// - Parameters:
    ///   - rsHudContentType: rsHudContentType description
    ///   - rsDelay: rsDelay description
    ///   - rsCompletion: rsCompletion description
    public func rsShowPKHUD(_ rsHudContentType: HUDContentType, rsDelay: TimeInterval, rsCompletion: ((Bool) -> Void)? = nil) {
        
        HUD.show(rsHudContentType, onView: self)
        HUD.hide(afterDelay: rsDelay, completion: rsCompletion)
    }
    
    /// 展示成功PKHUD
    /// - Parameter rsCompletion: rsCompletion description
    public func rsShowSuccessPKHUD(_ rsCompletion:@escaping (() -> Void)){
        
        HUD.flash(.success,onView:self,delay: 1.5) { (compled) in
            if compled{
                rsCompletion()
            }
        }
    }
    
    /// 展示错误PKHUD
    /// - Parameter rsCompleted: rsCompleted description
    public func rsShowFailurePKHUD(rsCompleted:@escaping (() -> Void)){
        
        HUD.flash(.error,onView:self,delay: 1.5) { (compled) in
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
    /// 展示Show-Toast内容
    /// - Parameters:
    ///   - message:  展示的信息 - 为空不展示
    ///   - duration: 展示的时间 - 默认1.5秒钟
    ///   - position: 展示的位置 - 默认在View底部
    public func rsShowToast(_ message: String, duration: TimeInterval = 1.5, position: ToastPosition = .bottom) {
        
        if !message.isEmpty {
            self.makeToast(message, duration: duration, position: position)
        }
    }
    
}

