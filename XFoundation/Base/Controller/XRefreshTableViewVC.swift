//
//  XRefreshTableViewVC.swift
//  
//
//  Created by xiaoniu on 2018/10/29.
//

import UIKit
import MJRefresh

class XRefreshTableViewVC: XTableViewVC {

    var refreshHeader: MJRefreshHeader?
    var refreshFooter: MJRefreshFooter?
    var hasMore : Bool? 
    
    var page : Int = 1
    
    var canUpdate: Bool? {
        didSet {
            if canUpdate == true {
                self.refreshHeader =  App.refreshHeader()
                self.refreshHeader?.setRefreshingTarget(self, refreshingAction: #selector(updateData))
                self.tableView.mj_header = self.refreshHeader
            } else {
                self.refreshHeader = nil
                self.tableView.mj_header = nil
            }
        }
    }
    
    var canAppend: Bool? {
        didSet {
            if canAppend == true {
                self.refreshFooter = App.refreshFooter()
                self.refreshFooter?.setRefreshingTarget(self, refreshingAction: #selector(appendData))
                
                self.tableView.mj_footer = self.refreshFooter
            } else {
                self.refreshFooter = nil
                self.tableView.mj_footer = nil
            }
        }
    }
    
    @objc func updateData() {
        self.page = 1 
        self.sendRequest(self.otherQueue)
    }
    
    @objc func appendData() {
        if self.hasMore == true {
            self.page = self.page + 1
            self.sendRequest(self.otherQueue) 
        } else {
            self.refreshFooter?.endRefreshingWithNoMoreData()
        }
    }
    
    func parseResult(req:XBaseRequest,res:XRequestResult) {
        if (self.page == 1) {
            self.refreshHeader?.endRefreshing()
        } else {
            self.refreshFooter?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canAppend = true
        self.canUpdate = true
    }
}
