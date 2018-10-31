//
//  RequestDemoVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/30.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class RequestDemoVC: XRequestVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func sendRequest(_ queue: XRequestQueue) {
    
        XBaseRequest.domain = "http://www.baidu.com"
        XTokenRequest.domain = "http://39.108.222.73:8080"
        XBaseRequest.publicParameters = ["term" : "ios"]
        
        let req = XTokenRequest.path("/qd_api/api/guideInfo/open/login", completion:{(req,res) in 

            print(res)
        })
        
        req.addParameter(key: "tel", value: "15118174201")
        req.addParameter(key: "password", value: "123456")
        
        queue.push(req)
    }
    
    
}
