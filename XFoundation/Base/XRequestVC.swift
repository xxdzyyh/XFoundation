//
//  XRequestVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/19.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

/// 和网络请求有关的试图控制器的基类
class XRequestVC: XBaseVC, XRequestQueueDelegate {
    func someRequestStart(queue: XRequestQueue) {
        if (queue.isEqual(self.mainQueue)) {
            // 显示进度
        }
    }
    
    func requestSuccess(queue: XRequestQueue, request: XBaseRequest, result: XRequestResult) {
        
    }
    
    func requestFailure(queue: XRequestQueue, request: XBaseRequest, result: XRequestResult) -> Bool {
        if (queue.isEqual(self.mainQueue)) {
            return true
        } else {
            return false
        }  
    }
    
    func allRequestFinished(queue: XRequestQueue) {
        
    }

    /**
        将请求放到这个队列，可以自动显示/隐藏 Loading
        - 当mainQueue任意请求开始时，Loading会显示，
        - 如果mainQueue有请求在进行，Loading就不会消失，
        - 当mainQueue所有请求结束时，Loading会隐藏起来
     */
    var mainQueue : XRequestQueue = XRequestQueue.init(name: "mainQueue")
    
    /**
        将请求放到这个队列，可以自动显示/隐藏 状态栏的网络请求指示器
         - 当mainQueue任意请求开始时，Loading会显示，
         - 如果mainQueue有请求在进行，Loading就不会消失，
         - 当mainQueue所有请求结束时，Loading会隐藏起来
     */
    var otherQueue : XRequestQueue  = XRequestQueue.init(name: "otherQueue")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.mainQueue.delegate = self
        self.otherQueue.delegate = self
        // Do any additional setup after loading the view.
        
        self.sendRequest()
    }
    
    func sendRequest() {
        
        XBaseRequest.domain = "http://www.baidu.com"
        XTokenRequest.domain = "http://39.108.222.73:8080"
        
        let req = XTokenRequest.path("/qd_api/api/guideInfo/open/login", completion:{(req,res) in 
            print(res)
        })
        
        req.addParameter(key: "tel", value: "15118174201")
        req.addParameter(key: "password", value: "123456")
        
        self.mainQueue.push(req)
    }
    
}
