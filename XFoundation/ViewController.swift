//
//  ViewController.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/18.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class ViewController: XDemoTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dataSource = [[ActionKey.key:ActionType.ViewController,ActionKey.desc:"XTopTabBar",ActionKey.value:"TopTabBarDemoVC"]]
    }

}

