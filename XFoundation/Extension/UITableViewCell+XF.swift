//
//  UITableViewCell+XF.swift
//  XFoundation
//
//  Created by sckj on 2020/7/25.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    // MARK: - 注册创建
    class func register(for tableView:UITableView, identifier:String? = nil) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
          reuseIdentifier = self.className
        }
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        if (path != nil) {
            let nib = UINib.init(nibName: className, bundle: classBundle)
            
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier!)
        } else {
            tableView.register(self, forCellReuseIdentifier: reuseIdentifier!)
        }
    }

    class func cell(for tableView: UITableView, identifier:String? = nil) -> (UITableViewCell) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
          reuseIdentifier = self.className
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        if cell == nil {
            register(for: tableView, identifier: reuseIdentifier!)
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        }
        return cell!
    }
}
