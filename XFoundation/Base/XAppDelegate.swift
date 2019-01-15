//
//  XAppDelegate.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/19.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import Bugly

public class XAppDelegate: UIResponder,UIApplicationDelegate {

    var window: UIWindow?
       
    func applicationDidFinishLaunching(_ application: UIApplication) {
        
    }
        
    //MARk:设置第三方
    func setupApp(_ app:App?) {
        
        if (app?.buglykey != nil) {
            Bugly.start(withAppId: app?.buglykey)
        }
        
        if (app?.umengKey != nil) {
            
        } 
    }
    
}
