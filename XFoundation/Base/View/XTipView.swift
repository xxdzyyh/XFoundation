//
//  XTipView.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import SnapKit

/// 各种提示
class XTipView: UIView {

    var title : String?
    var image : String?
    var titleLabel : UILabel?
    var imageView: UIImageView?
    
    /// 外界传入一个可以定义的视图
    var customView : UIView?
    
    init(title: String? , image: String?) {
        super.init(frame: CGRect.zero)
        self.title = title
        self.image = image
        
        setup()
    }
    
    init(title: String? , customView: UIView?) {
        super.init(frame: CGRect.zero)
        self.title = title
        self.customView = customView
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        
        let array = NSMutableArray.init()
        
        if (self.title != nil) {
            self.titleLabel = UILabel.init()
            self.titleLabel?.text = self.title
            
            array.add(self.titleLabel!)
        }
        
        if self.image != nil {
            self.imageView = UIImageView.init(image: UIImage.init(named: self.image!))
            
            array.add(self.imageView!)
        }
        
        if self.customView != nil {
            array.add(self.customView!)
        }
        
        let stackView = UIStackView.init(arrangedSubviews: array as! [UIView])
        
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 15
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    
    
    
}
