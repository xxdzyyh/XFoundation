//
//  UITableViewCell+XF.swift
//  XFoundation
//
//  Created by sckj on 2020/7/25.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    /// 注册 cell
    /// - Parameters:
    ///   - tableView: 目标 tableView
    ///   - identifier: 重用标志，可以不传
    class func register(for tableView:UITableView, identifier:String? = nil) {
        let reuseIdentifier = identifier == nil ? self.className : identifier
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        if (path != nil) {
            let nib = UINib.init(nibName: className, bundle: classBundle)
            
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier!)
        } else {
            tableView.register(self, forCellReuseIdentifier: reuseIdentifier!)
        }
    }

    class func cell(for tableView: UITableView, identifier:String? = nil) -> Self {
        let reuseIdentifier = identifier == nil ? self.className : identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        if cell == nil {
            register(for: tableView, identifier: reuseIdentifier!)
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier!)
        }
        return cell as! Self
    }
}
