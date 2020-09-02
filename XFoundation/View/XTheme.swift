//
//  XTheme.swift
//  XFoundation
//
//  Created by sckj on 2020/9/2.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// 应用主题色，比如微信绿色，支付宝蓝色
    static var themeColor : UIColor = UIColor.orange
    
    /// 背景色，一般用于viewController.view.backgroundColor
    static var backgroundColor : UIColor = UIColor(hex: 0xECECEC)
    /// 背景色，一般用于背景颜色为backgroundColor的视图上面的视图，比如cell,viewController.view.subviews
    static var backgroundColorLighten : UIColor = UIColor(hex: 0xECECEC)
    /// 标题颜色，文字中最显眼
    static var titleTextColor : UIColor = UIColor(hex: 0x333333)
    /// 主文字颜色，文字中较显眼
    static var mainTextColor : UIColor = UIColor(hex: 0x666666)
    /// 描述文字颜色，文字中较不显眼
    static var descriptionTextColor : UIColor = UIColor(hex: 0x999999)
    /// 占位文字颜色，textField,textView
    static var placeholderColor : UIColor = UIColor(hex: 0x333333)
    
    /// 分割线颜色，一般用于背景颜色为backgroundColor的视图上面的视图
    static var separatorColor : UIColor = UIColor(hex: 0xECECEC)
    /// 分割线颜色，
    static var separatorColorLighten : UIColor = UIColor.white
}
