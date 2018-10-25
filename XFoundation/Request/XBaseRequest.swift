//
//  XBaseRequest.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/22.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import AFNetworking

typealias Completion = (XBaseRequest,XRequestResult) -> ();

class XBaseRequest: NSObject {
    static var domain : String?
    
    static var sessionManager = AFHTTPSessionManager.init(baseURL: nil)
    
    var path : String?
    
    // 请求结束回调
    var completion : Completion?
    
    // 是否请求已经发出，正在进行中
    var isGoing : Bool?
    
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
        self.execute(finishBlock: nil)
    }
    
    class func path(_ path:String,completion:Completion?) -> (XBaseRequest) {

        return XBaseRequest.path(path, parameter: nil, completion: completion)
    }
    
    class func path(_ path:String,parameter:NSDictionary?,completion:Completion?) -> (XBaseRequest) {
        let request = XBaseRequest.init()
        
        request.completion = completion
        request.path = path
        
        if parameter != nil {
            request.addParameters(parameters: parameter!)
        }
        
        return request
    }

    func cancel() {
        
    }
    
    /// 发出请求
    ///
    /// - Parameter finishBlock: 通知请求队列请求的情况
    func execute(finishBlock:Completion?) {
        
        if XBaseRequest.domain == nil {
            NSLog("domain为空，先设置domain")
        }
        
        // domain是static变量，子类和父类共享同一个对象，继承后对子类domain赋值就可以
        let url = NSString.init(format: "%@%@", XBaseRequest.domain!,self.path!)
        
        let manager = XBaseRequest.sessionManager
        
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
                        
                        let result = XRequestResult.init()
                        
                        result.configWithDictionary(dictionary: dict)
                        
                        self.sendCompletion(result: result)
                        
                        if (finishBlock != nil) {
                            finishBlock!(self,result)
                        }
                    } else {
                        // 解析出来不是字典，就是出错了，不用管
                        let result = XRequestResult.init()
                        
                        result.code = -1;
                        result.desc = "发生了未知错误"
                        result.success = false
        
                        result.configWithDictionary(dictionary: nil)
                        
                        self.sendCompletion(result: result)
                    
                        if (finishBlock != nil) {
                            finishBlock!(self,result)
                        }
                    }

                } catch {
                    // 数据无法解析，就是出错了，不用管
                    let result = XRequestResult.init()
                    
                    result.code = -1;
                    result.desc = "发生了未知错误"
                    result.success = false
                    
                    result.configWithDictionary(dictionary: nil)
                    
                    self.sendCompletion(result: result)
                    
                    if (finishBlock != nil) {
                        finishBlock!(self,result)
                    }
                }
            } else {
                // 请求成功了，但是没有任何数据返回
                let result = XRequestResult.init()
                
                result.code = 200;
                result.success = true
                result.configWithDictionary(dictionary: nil)
                
                self.sendCompletion(result: result)
                
                if (finishBlock != nil) {
                    finishBlock!(self,result)
                }
            }
        } 
        
        let failureBlock = {(task: URLSessionDataTask?,error : NSError) in
            print(error.localizedDescription)
            
            let result = XRequestResult.init()
            
            result.code = -1;
            result.desc = error.localizedDescription
            result.success = false
            result.configWithDictionary(dictionary: nil)
            
            self.sendCompletion(result: result)
            
            if (finishBlock != nil) {
                finishBlock!(self,result)
            }
        }
       
        self.isGoing = true
        manager.post(url as String, parameters: params, progress: nil, success: successBlock, failure : failureBlock as? (URLSessionDataTask?, Error) -> Void)
    }
    
    private func sendCompletion(result : XRequestResult) {
        self.isGoing = false
        if self.completion != nil {
            self.completion!(self,result)
        }
    }
}

