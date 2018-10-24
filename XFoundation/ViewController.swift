//
//  ViewController.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/18.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        XBaseRequest.domain = "http://www.baidu.com"
        XTokenRequest.domain = "http://39.108.222.73:8080"

        let req = XTokenRequest.path("/qd_api/api/guideInfo/open/login", completion:{(req,res) in 
            print(res)
        })
        
        req.addParameter(key: "tel", value: "15118174201")
        req.addParameter(key: "password", value: "123456")
        
        req.start()

    }


}

