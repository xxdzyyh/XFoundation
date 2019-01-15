//
//  XTokenRequest.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/24.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

/// 一般而言，客户端可以使用token来代表用户登录信息的所以需要登录请求都会带一个token参数
public class XTokenRequest: XBaseRequest {
    
    static var tokenKeyName: String = "token"
    var token : String?
    
    
    
}
