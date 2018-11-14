//
//  XTableViewVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import SnapKit

class XTableViewVC: XRequestVC,UITableViewDelegate,UITableViewDataSource {
    
    var dataSource : NSMutableArray? {
        didSet {
            self.tableView.reloadData()
        } 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - subclass need override
    func cellClass() -> AnyClass? {
        return XTableViewCell.self
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.cellClass() != nil {
            let className: String = NSStringFromClass(self.cellClass()!)
            
            if let classType = NSClassFromString(className) as? XTableViewCell.Type {
                return classType.cellForTableView(tableView)
            }
        }
                        
        return XTableViewCell.cellForTableView(tableView)
    }
    
    //MARK: - setup
    
    var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        
        tableView.showsVerticalScrollIndicator = false;
        tableView.showsHorizontalScrollIndicator = false;
        tableView.tableFooterView = UIView.init();
        tableView.isDirectionalLockEnabled = true;
        tableView.rowHeight = 44;
        
        return tableView
    }()

}
