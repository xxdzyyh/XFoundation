//
//  XRequestResult.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/22.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class XRequestResult: NSObject {
    /// 请求成功，返回的证书数据
    var data : Any?
    
    /// 后台定义的错误类型，比如token失效
    var code : Int?
    
    /// 后台可以返回一个提示给客户端，客服端直接显示，一般success = NO，提示用户
    var desc : String?
    
    /// 后台返回的结果，请求成功了，且没有其他问题（比如token失效等）
    var success : Bool?
    
    /// 子类重写这个方法，后台的传过来的key一直在变，具体是什么，要看具体的项目
    ///
    /// - Parameter dictionary: 请求到原始的json数据转成的字典，还没有解析过
    func configWithDictionary( dictionary : NSDictionary?) {
        self.data = dictionary
    }
}
