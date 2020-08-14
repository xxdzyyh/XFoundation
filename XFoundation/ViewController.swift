//
//  ViewController.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/18.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class ViewController: XDemoTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.dataSource = [[ActionKey.key:ActionType.ViewController,ActionKey.desc:"XTopTabBar",ActionKey.value:"TopTabBarDemoVC"],
                           [ActionKey.key:ActionType.ViewController,ActionKey.desc:"CollectionView",ActionKey.value:"CollectionViewDemoVC"],
                           [ActionKey.key:ActionType.ViewController,ActionKey.desc:"TwoButtonSegment",ActionKey.value:"TwoButtonSegmentVC"],
                            [ActionKey.key:ActionType.ViewController,ActionKey.desc:"IGList Single Section",ActionKey.value:"SingleSectionDemoVC"]
                           
        ]
    }

}

