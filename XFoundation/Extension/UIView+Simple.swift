//
//  UIView+Simple.swift
//  SPARKVIDEO
//
//  Created by sckj on 2020/7/23.
//

import UIKit

extension UIView {
    
    var height : CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var rect = self.frame
            rect.size.height =  newValue
            self.frame = rect
        }
    }
    
    var width : CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var rect = self.frame
            rect.size.width =  newValue
            self.frame = rect
        }
    }
    
    func addCornerRadius(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addShadow(shadowColor:UIColor,shadowOpacity : Float = 0.3,shadowOffset : CGSize = CGSize(width:3,height:3),shadowRadius : CGFloat = 5.0) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
}
