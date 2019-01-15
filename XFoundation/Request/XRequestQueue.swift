//
//  XRequestQueue.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/25.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

// @objc protocol XRequestQueueDelegate { }
// 为什么要加@objc
// 因为 Swift 的 protocol 是可以除了 class 以外的其他类型遵守的，
// 而对于像 struct 或是 enum 这样的类型，本身就不通过引用计数来管理内存，
// 所以也不可能用 weak 这样的 ARC 的概念来进行修饰
// 想要在 Swift 中使用 weak delegate，我们就需要将 protocol 限制在 class 内。
// 一种做法是将 protocol 声明为 Objective-C 的，这可以通过在 protocol 前面加上 @objc 关键字来达到，
// Objective-C 的 protocol 都只有类能实现，因此使用 weak 来修饰就合理了
// 
// 协议后面添加class，表明这个协议只能由class来实现
protocol XRequestQueueDelegate : class {
        
    /// 队列中有请求开始的，开始显示加载进度
    ///
    /// - Parameter queue: 具体请求队列
    func someRequestStart(queue:XRequestQueue) 

    /// 某个请求成功
    ///
    /// - Parameter request: 成功的请求
    func requestSuccess(queue:XRequestQueue,request:XBaseRequest,result:XRequestResult)

    /// 某个请求失败
    ///
    /// - Parameters:
    ///   - queue: 请求所在的队列
    ///   - request: 失败的请求
    ///   - result: 结果
    /// - Returns: 
    func requestFailure(queue:XRequestQueue,request:XBaseRequest,result:XRequestResult) -> Bool
    
    /// 队列中所有的请求结束了
    ///
    /// - Parameter queue: 具体请求队列
    func allRequestFinished(queue:XRequestQueue)
}

public class XRequestQueue: NSObject {
    
    /// 名称，可以用来取分队列
    var name: String?
    
    init(name: String) {
        self.name = name
    }
    
    /// 代理，实现XRequestQueueDelegate协议
    weak var delegate: XRequestQueueDelegate?
    
    /// 队列中的请求 
    var requests : NSMutableArray = {
        return NSMutableArray.init()  
    }()
    
    func push(_ request:XBaseRequest) {
        self.requests.add(request)
        if (self.requests.count == 1) {
            if (self.delegate != nil) {
                self.delegate?.someRequestStart(queue: self)
            }
            self.execute()
        }
    }
    
    func pop() {
        if (self.requests.count >= 1) {
            // 移除第一个元素
            self.requests.removeObject(at: 0)
            if (self.requests.count >= 1) {
                self.execute()
            } else {
                // 通知代理，请求都结束了
                if (self.delegate != nil) {
                    self.delegate!.allRequestFinished(queue: self)
                }
            }
        }
    }
    
    /// 暂停操作什么都不用做
    func pause() {
        
    }
    
    /// 取消某个请求，只是将它移出队列
    ///
    /// - Parameter request: 要取消的请求
    func cancel(_ request:XBaseRequest) {
        if (request.isGoing == true) {
            return
        } else {
            self.requests.remove(request)
        }
    }
    
    private func execute() {
        let request = self.requests.firstObject
        
        if (request == nil) {
            return;
        }
        
        let finishBlock : Completion = {(req:XBaseRequest,res:XRequestResult) in 
            if (res.success == true) {
                // 请求成功，出队列
               self.pop()
            } else {
                if (self.delegate != nil) {
                    // 失败了是否需要暂停
                    let stop = self.delegate!.requestFailure(queue: self, request: req, result: res)
                    
                    if (stop == true) {
                        self.pause()
                    } else {
                        self.pop()
                    }
                }
            }
        } 
        
        (request! as! XBaseRequest).execute(finishBlock: finishBlock)
    }

}
