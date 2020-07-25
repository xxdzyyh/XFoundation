//
//  DateExDemoVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/31.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class DateExDemoVC: XBaseVC {

    struct Temp {
        static var top: Double = 100.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let string = "2018-10-31 12:30:21"
//        let res = Date.stringToYearMonthDay(dateString: string)
//        
//        self.addLabel(text: "let string = \"2018-10-31 12:30:21\" \nDate.stringToYearMonthDay(dateString: string) \n\(res!)")
//        
//        let time2 = "2018-10-31 12:32:31"        
//        let date2 = Date.date(defaultFormatTime: time2)
//        let res2 = date2?.liveTimeAgo(time: string)
//        
//        self.addLabel(text: "let string = \"2018-10-31 12:30:21\" \nlet time2 = \"2018-10-31 12:32:31\"\nlet date2 = Date.date(defaultFormatTime: time2)\ndate2?.liveTimeAgo(time: string) \n\(res2!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Temp.top = 100.0
    }
    
    func addLabel(text:String) {
                
        let label = UILabel.init()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = text
        label.sizeToFit()
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(Temp.top)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }
        
        Temp.top = Temp.top + Double(label.intrinsicContentSize.height) + 20.0
    }
}
