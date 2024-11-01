//
//  ViewController.swift
//  RSExtension
//
//  Created by RisingSun on 10/28/2024.
//  Copyright (c) 2024 RisingSun. All rights reserved.
//

import UIKit
import RSExtension

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "")
        image?.rsImageToData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

