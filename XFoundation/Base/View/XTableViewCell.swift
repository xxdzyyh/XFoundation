//
//  XTableViewCell.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

public class XTableViewCell: UITableViewCell {

    var data : Any?
    
    //MARK: - 高度计算
        
    static func cellHeight() -> (CGFloat) {
        return 44.0
    }
    
    static func cellHeightWithData(_ data:Any) -> (CGFloat)  {
        return 44.0
    }
    
    //MARK: - 数据填充
    
    func configWithData(_ data:Any) {
        self.data = data
    }
    
    //Mark: - cell生成
    
    static func registerForTableView(_ tableView:UITableView) {
        let className = NSStringFromClass(self) 
        
        self.registerForTableView(tableView, withIdentify: className)
    }
    
    static func registerForTableView(_ tableView:UITableView,withIdentify identify:String) {
        let className = NSStringFromClass(self) 
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        
        if (path != nil) {
            let nib = UINib.init(nibName: className, bundle: classBundle)
            
            tableView.register(nib, forCellReuseIdentifier: identify)
        } else {
            print("cell注册失败，\(className)")
            
            tableView.register(self, forCellReuseIdentifier: className)
        }
    }

    static func cellForTableView(_ tableView: UITableView) -> (UITableViewCell) {
        let className = NSStringFromClass(self) 
      
        return self.cellForTableView(tableView, withIdentify: className)
    }
    
    static func cellForTableView(_ tableView: UITableView, withIdentify identify:String) -> (UITableViewCell) {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identify)
        
        if cell == nil {
            self.registerForTableView(tableView, withIdentify: identify)
            
            cell = tableView.dequeueReusableCell(withIdentifier: identify)
        } 
        
        return cell!
    }
}
