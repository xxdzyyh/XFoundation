//
//  App.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/18.
//  Copyright © 2018年 com.learn. All rights reserved.
//

// App相关的形象
// Theme
// 

import UIKit
import MJRefresh

public class App: NSObject {
    
    /// 单例
    static let sharedApp = App()
    private override init() {
        
    }

    //MARK: - UI定制 
    
    //MARK:主题颜色
    var themeColor:UIColor = {
        return UIColor.orange
    }() 
      
    var textBlackColor:UIColor = {
        return UIColor.init(red: 153.0/255, green: 153.0/255, blue: 153.0/255, alpha: 1);
    }()
    
    var textGrayColor:UIColor = {
        return UIColor.init(red: 102.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1);
    }()
    
    var seperatorColor:UIColor = {
        return UIColor.init(red: 224.0/255, green: 224.0/255, blue: 224.0/255, alpha: 1);
    }()    
    
    //MARK:空数据提示
    var noDataTitle : String?
    var noDataImage : String?
    var noNetworkTitle : String?
    var noNetworkImage : String?
    
    // 刷新    
    static func refreshHeader() -> (MJRefreshHeader) {
        return MJRefreshNormalHeader.init()
    }
    
    static func refreshFooter() -> (MJRefreshFooter) {
        return MJRefreshBackNormalFooter.init()
    }
    
    //MARK:第三方 -
    var umengKey : String?
    var buglykey : String?

}


 


