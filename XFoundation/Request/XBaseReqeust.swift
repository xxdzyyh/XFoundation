//
//  XBaseReqeust.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/22.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import AFNetworking

typealias Completion = (XBaseReqeust,XReqeustResult) -> ();

class XBaseReqeust: NSObject {
    static var domain : String?
    var path : String?
    
    // 请求结束回调，请求通过队列执行
    var completion : Completion?
    
    // 请求结束回调，请求没有通过队列执行
    var finishBlock : Completion?
    
    var isCancel : Bool?
    
    //MARK: - 参数
    
    var params : NSMutableDictionary?
    
    ///  添加请求参数    
    ///
    /// - Parameters:
    ///   - key: 参数名
    ///   - value: 参数值
    func addParameter(key:String,value:Any?) -> () {
        if self.params == nil  {
            self.params = NSMutableDictionary.init()
        }
        
        self.params?.setValue(value, forKey: key)
    }
    
    /// 添加多个参数
    ///
    /// - Parameter parameters: 参数字典
    func addParameters(parameters:NSDictionary) {
        if self.params == nil  {
            self.params = NSMutableDictionary.init()
        }
        
        self.params!.setDictionary(params as! [AnyHashable : Any])
    }
    
    //MARK: - 获取数据
    
    func start() {
        
    }
    
    class func path(path:String,completion:Completion?) -> (XBaseReqeust) {
        let request = XBaseReqeust.init()
        
        request.completion = completion
        request.path = path
        
        return request
    }
    
    func cancel() {
        
    }
    
    private func execute(completion:Completion?) {
        
        if XBaseReqeust.domain == nil {
            NSLog("domain为空，先设置domain")
        }
        
        let url = NSString.init(format: "%@%@", XBaseReqeust.domain!,self.path!)
        
        let manager = AFHTTPSessionManager.init()
        
        manager.requestSerializer = AFHTTPRequestSerializer.init()
        manager.responseSerializer = AFHTTPResponseSerializer.init()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(array: ["application/json"]) as? Set<String>
        manager.requestSerializer.timeoutInterval = 30.0
        
        let successBlock = {(task: URLSessionDataTask,responseObj: Any?) in 
            if (responseObj != nil) {
                do {
                    let obj = try JSONSerialization.jsonObject(with: responseObj as! Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    
                    print(obj)
                    
                    if (obj is NSDictionary) {
                        let dict = obj as! NSDictionary
                        
                        let result = XReqeustResult.init()
                        
                        result .configWithDictionary(dictionary: dict)
                        
                        self.sendCompletion(result: result)
                    } else {
                        // 解析出来不是字典，就是出错了，不用管
                        let result = XReqeustResult.init()
                        
                        result.code = -1;
                        result.desc = "发生了未知错误"
                        result.success = false
                        
                        result.configWithDictionary(dictionary: nil)
                        
                        self.sendCompletion(result: result)
                    }

                } catch {
                    // 数据无法解析，就是出错了，不用管
                    let result = XReqeustResult.init()
                    
                    result.code = -1;
                    result.desc = "发生了未知错误"
                    result.success = false
                    
                    result.configWithDictionary(dictionary: nil)
                    
                    self.sendCompletion(result: result)
                }
            } else {
                // 请求成功了，但是没有任何数据返回
                let result = XReqeustResult.init()
                
                result.code = 200;
                result.success = true
                result.configWithDictionary(dictionary: nil)
                
                self.sendCompletion(result: result)
            }
        } 
        
        let failureBlock = {(task: URLSessionDataTask?,error : NSError) in
            print(error.localizedDescription)
            
            let result = XReqeustResult.init()
            
            result.code = -1;
            result.desc = error.localizedDescription
            result.success = false
            result.configWithDictionary(dictionary: nil)
            
            self.sendCompletion(result: result)
        }
       
        manager.post(url as String, parameters: params, progress: nil, success: successBlock, failure : failureBlock as? (URLSessionDataTask?, Error) -> Void)
    }
    
    private func sendCompletion(result : XReqeustResult) {
        if (self.finishBlock != nil) {
            self.finishBlock!(self,result)
        }
        
        if self.completion != nil {
            self.completion!(self,result)
        }
    }
}

