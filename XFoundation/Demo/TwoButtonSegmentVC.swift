//
//  TwoButtonSegmentVC.swift
//  XFoundation
//
//  Created by sckj on 2020/8/13.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

class TwoButtonSegmentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.segment)
        self.view.addSubview(self.sysSeg)
        self.segment.snp.makeConstraints { (make) in
            make.top.equalTo(80)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        self.sysSeg.snp.makeConstraints { (make) in
            make.top.equalTo(180)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
    }

    lazy var segment: TwoButtonSegmentControl = {
        let v = TwoButtonSegmentControl.init(leftTitle: "123", rightTitle: "asd", normalColor: .blue, selectColor: .cyan, normalTextColor: .white, selectTextColor: .black)
        return v
    }()
    
    lazy var sysSeg: UISegmentedControl = {
        let v = UISegmentedControl.init(items: ["123","asd"])
        v.tintColor = .cyan
        return v
    }()
}
