//
//  TopTabBarDemoVC.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/11/2.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

class TopTabBarDemoVC: XBaseVC,XTopTabBarDelegate {

    var topBar : XTopTabBar = XTopTabBar.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 45))
    var scrollView : UIScrollView = UIScrollView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.topBar)
        self.view.addSubview(self.scrollView)
        
        for i in 0..<3 {
            
            let vc = UIViewController.init()
            
            let w = self.view.bounds.size.width
            
            vc.view.frame = CGRect(x: CGFloat(i) * w, y: 0.0, width: w, height: (self.view.bounds.size.height - 45))
            vc.view.backgroundColor = UIColor.init(red: CGFloat(Double(30*i)/255.0), green: CGFloat(Double(30*i)/255.0), blue: CGFloat(Double(10*i)/255.0), alpha: 1)
            
            self.scrollView.addSubview(vc.view)
        } 
        
        self.scrollView.frame = CGRect(x: 0, y: 45, width: self.view.bounds.size.width, height: (self.view.bounds.size.height - 45))
        self.scrollView.contentSize = CGSize(width: (self.view.bounds.size.width * 3.0), height: (self.view.bounds.size.height - 45))
        
        self.topBar.scrollView = self.scrollView
        self.topBar.delegate = self
    }
    
    func titlesForTopTabBar(topTabBar: XTopTabBar) -> (Array<String>) {
        return ["天一","如是","长生"]
    }
    
    func topTabBarDidSelectedItemAtIndex(topTabBar: XTopTabBar, index: Int) {
        print(index)
    }

}
