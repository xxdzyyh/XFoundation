//
//  XInsetLabel.swift
//  XFoundation
//
//  Created by xiaoniu on 2019/1/7.
//  Copyright © 2019 com.learn. All rights reserved.
//

import UIKit

open class XInsetLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.insets));
    }
    
    override open var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        
        size.width += (self.insets.left+self.insets.right)
        size.height += (self.insets.top+self.insets.bottom);
        
        return size;
    }
}
