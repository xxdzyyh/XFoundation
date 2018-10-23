//
//  XRequestVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/19.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

/// 和网络请求有关的试图控制器的基类
class XRequestVC: XBaseVC {

    /**
        将请求放到这个队列，可以自动显示/隐藏 Loading
        - 当mainQueue任意请求开始时，Loading会显示，
        - 如果mainQueue有请求在进行，Loading就不会消失，
        - 当mainQueue所有请求结束时，Loading会隐藏起来
     */
    var mainQueue : NSMutableArray = {
        return NSMutableArray.init()
    }()
        
    /**
        将请求放到这个队列，可以自动显示/隐藏 状态栏的网络请求指示器
         - 当mainQueue任意请求开始时，Loading会显示，
         - 如果mainQueue有请求在进行，Loading就不会消失，
         - 当mainQueue所有请求结束时，Loading会隐藏起来
     */
    var otherQueue : NSMutableArray = {
        return NSMutableArray.init()  
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
