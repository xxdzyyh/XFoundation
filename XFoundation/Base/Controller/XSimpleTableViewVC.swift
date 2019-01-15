//
//  XSimpleTableViewVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/30.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

let kType: String  = "type"
let kDesc = "desc"
let kValue = "value"

enum ActionType : Int {
    case Controller
    case View
}

open class XSimpleTableViewVC: XTableViewVC {

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 60
        // Do any additional setup after loading the view.
    }
    
    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell");
        
        if cell == nil {
            cell = UITableViewCell.init(style:UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        let data : NSDictionary = self.dataSource?[indexPath.row] as! NSDictionary;
        
        let desc = data[kDesc]
        let value = data[kValue]
        
        cell?.textLabel?.text = desc as? String
        cell?.detailTextLabel?.text = value as? String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data : NSDictionary = self.dataSource?[indexPath.row] as! NSDictionary;
      
        let value = data[kValue]
        let type = data[kType]
            
        switch type as! ActionType {
        case ActionType.Controller: do {
            let obj = XRuntimeHelper.instanceForClassName(value as! String)
            
            self.navigationController?.pushViewController(obj as! UIViewController, animated: true)
        }
            break
        case .View:
            let vc = UIViewController.init()
            
            let obj = XRuntimeHelper.instanceForClassName(value as! String)
            
            vc.view.addSubview(obj as! UIView)
            
            self.navigationController?.pushViewController(obj as! UIViewController, animated: true)
        }

    }
}
