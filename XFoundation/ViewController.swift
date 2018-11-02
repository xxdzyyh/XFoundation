//
//  ViewController.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/18.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class ViewController: XSimpleTableViewVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dataSource = [[kType:ActionType.Controller,kDesc:"请求数据",kValue:"RequestDemoVC"],
        [kType:ActionType.Controller,kDesc:"日期处理",kValue:"DateExDemoVC"],
        [kType:ActionType.Controller,kDesc:"XTopTabBar",kValue:"TopTabBarDemoVC"]]
    }

}

