//
//  TableViewCell.swift
//  ZJVideo
//
//  Created by sckj on 2020/8/18.
//

import UIKit

enum XImagePostion : Int {
    case left
    case top
    case bottom
    case right
}

extension UIButton {
    
    /// 设置按钮图片位置，通过titleEdgeInsets 和 imageEdgeInsets实现
    /// - Parameters:
    ///   - postion: 按钮的位置
    ///   - space: title 和 image 之间的距离
    func setImagePostion(_ postion:XImagePostion,space:CGFloat) {
        let imageSize = self.imageView?.intrinsicContentSize ?? CGSize.zero
        let titleSize = self.titleLabel?.intrinsicContentSize ?? CGSize.zero
        switch postion {
        case .top:
            self.titleEdgeInsets = UIEdgeInsets(top: imageSize.height + space, left: -imageSize.width, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - space, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            self.titleEdgeInsets = UIEdgeInsets(top: -imageSize.height-space/2, left: -imageSize.width, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: titleSize.height+space/2, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            self.titleEdgeInsets = UIEdgeInsets(top:0, left:space, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space, bottom: 0, right: 0)
        case .right:
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width-space/2, bottom: 0, right: imageSize.width+space/2);
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width+space, bottom: 0, right: -titleSize.width-space);
        }
    }
}
