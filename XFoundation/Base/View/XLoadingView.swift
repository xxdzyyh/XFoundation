//
//  XLoadingView.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

public class XLoadingView: XTipView {

    var indicatorView = UIActivityIndicatorView.init(style: .gray)
    
    func setupLoading() {
    
        let transform = CGAffineTransform.init(scaleX: 1.7, y: 1.7)
        
        self.indicatorView.transform = transform
    }
    
    init() {
        super .init(title: nil, customView: self.indicatorView)
        
        self.setupLoading()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if (self.superview != nil) {
            self.indicatorView.startAnimating()
        } else {
            self.indicatorView.stopAnimating()
        }
    }
    
}
