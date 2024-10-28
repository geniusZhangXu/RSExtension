//
//  RSScrollViewExtension.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import MJRefresh
import Foundation


/// UIScrollView-Extension
extension UIScrollView{
    
    /// 添加头部刷新回调
    /// - Parameter rsRefreshingBlock: rsRefreshingBlock description
    public func rsHeaderRefresh(rsRefreshingBlock: @escaping ()->Void) {
        
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: rsRefreshingBlock)
    }
    
    /// 添加底部刷新回调 - 隐藏底部Lable展示
    /// - Parameter rsRefreshingBlock: rsRefreshingBlock description
    public func rsFooterRefresh(rsRefreshingBlock: @escaping ()->Void) {
        
        let rsFooter = MJRefreshAutoNormalFooter(refreshingBlock: rsRefreshingBlock)
        /// 上拉加载更多隐藏状态文案
        rsFooter.isRefreshingTitleHidden = true
        rsFooter.stateLabel?.isHidden = true
        self.mj_footer = rsFooter
    }
    
    /// 停止刷新
    public func rsEndRefreshing() {
        
        if self.mj_header != nil {
            self.mj_header!.endRefreshing()
        }
        if self.mj_footer != nil {
            self.mj_footer!.endRefreshing()
        }
    }
    
    /// 停止刷新+没有更多的数据
    public func rsEndRefreshingWithNoMoreData() {
        
        if self.mj_header != nil {
            self.mj_header!.endRefreshing()
        }
        if self.mj_footer != nil {
            self.mj_footer!.endRefreshingWithNoMoreData()
        }
    }
    
}


