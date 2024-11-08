//
//  ViewController.swift
//  RSExtension
//
//  Created by RisingSun on 10/28/2024.
//  Copyright (c) 2024 RisingSun. All rights reserved.
//

import UIKit
import RSExtension
import ProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let okButton = UIButton.init(type: .system)
        okButton.setTitle("展示", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        okButton.addTarget(self, action: #selector(okButtonClickEvent), for: .touchUpInside)
        okButton.frame = CGRect.init(x: (UIScreen.main.bounds.size.width - 100)/2, y: 400, width: 100, height: 100)
        self.view.addSubview(okButton)
        
    }

    @objc func okButtonClickEvent(){
        
        ProgressHUD.colorBanner = .orange
        ProgressHUD.banner("Banner title", "Banner message to display.")
        /// delay参数表示展示的时长
        /// ProgressHUD.banner("Banner title", "Message to display.", delay: 5.0)
        /// 进度UI
        /// ProgressHUD.animate("Some text...", interaction: false)
        /// ballVerticalBounce动画样式
        /// ProgressHUD.animate("Please wait...", .ballVerticalBounce)
        /// 一次性动画-自己消失
        /// ProgressHUD.symbol("Some text...", name: "sun.max")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

