//
//  XBaseVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/19.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

/// 所有自定义的控制器都继承自XBaseVC
open class XBaseVC: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }

}
