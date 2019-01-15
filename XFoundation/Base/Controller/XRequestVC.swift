//
//  XRequestVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/19.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

import SVProgressHUD
import SnapKit

/// 和网络请求有关的试图控制器的基类
open class XRequestVC: XBaseVC, XRequestQueueDelegate {

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
 
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainQueue.delegate = self
        self.otherQueue.delegate = self
        // Do any additional setup after loading the view.
        
        // 一般进入页面会发送一个请求
        self.sendRequest(self.mainQueue)
    }
    
    /// 子类重写，发送页面主要请求，一般一个页面只有一个请求，但是有可能有多个，这个将一个作为默认
    ///
    /// - Parameter queue: 请求进行的队列
    func sendRequest(_ queue:XRequestQueue) {
        
    }
    
    //MARK: - XRequestQueueDelegate
    
    func someRequestStart(queue: XRequestQueue) {
        if (queue.isEqual(self.mainQueue)) {
            // 显示进度
            self.showLoadingView()
        } else {
            
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
        if (queue.isEqual(self.mainQueue)) {
            self.hideLoadingView()
        }
    }

    //MARK: - 加载指示器
    var activityIndicatorView : UIActivityIndicatorView?
    
    var loadingView : XLoadingView = XLoadingView.init()
    
    
    func setupLoading() {
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    /// 显示加载中菊花
    func showLoadingView() {
        self.view.addSubview(self.loadingView)
        
        self.loadingView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    /// 隐藏加载中菊花
    func hideLoadingView() {
        self.loadingView.removeFromSuperview()
    }
}
