//
//  XRuntimeHelper.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/29.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class XRuntimeHelper: NSObject {
    
    static func instanceForClassName(_ className : String) -> AnyObject {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let cla : AnyClass = NSClassFromString(nameSpace+"."+className)!
        let realClass = cla as! NSObject.Type
        
        let obj = realClass.init();
        
        return obj
    }

}
