//
//  UIView+Line.swift
//  StoreKit
//
//  Created by sckj on 2020/7/21.
//  Copyright © 2020 sckj. All rights reserved.
//

import UIKit

extension UIView {

    /// 添加一条线,如果这个方法可以满足需求，优先使用这个方法
    /// - Parameters:
    ///   - position: 线的位置
    ///   - lineColor: 线的颜色
    ///   - startInset: 起始内间距，默认0
    ///   - endInset: 结束内间距，默认0
    ///   - lineWidth: 线的宽，默认1pt
    ///   - isOnePixelWidth: 一像素线，默认false
    ///   - ignoreIfExist: 相同位置如果已经存在XLineView，忽略本次添加
    func addLine(position:XLinePostion = .bottom,lineColor:UIColor = UIColor.white,startInset:CGFloat = 0,endInset:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
        
        if self.autoresizesSubviews == false {
            #if DEBUG
            fatalError("autoresizesSubviews为false会导致添加的线显示异常")
            #else
            print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
            print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
            print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
            #endif
        }
        
        let startTag = 5432
        if ignoreIfExist {
            let res = self.viewWithTag(startTag + position.rawValue)
            if res != nil && res is XLineView {
                return
            }
        }
        
        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        switch position {
        case .top:
           rect = CGRect(x: startInset, y: 0, width: self.width - startInset - endInset, height: lineWidth)
           v.autoresizingMask = [.flexibleWidth ,.flexibleRightMargin]
        case .bottom:
           rect = CGRect(x: startInset, y: self.height-lineWidth, width: self.width - startInset - endInset, height: lineWidth)
           v.autoresizingMask = [.flexibleWidth , .flexibleTopMargin]
        case .left:
           rect = CGRect(x: 0, y: startInset, width: lineWidth, height: self.height-startInset - endInset)
           v.autoresizingMask = [.flexibleHeight]
        case .right:
           rect = CGRect(x: self.width-lineWidth, y: startInset, width: lineWidth, height: self.height - startInset - endInset)
           v.autoresizingMask = [.flexibleHeight]
        case .leftTopToRightBottom:
           rect = self.bounds
           v.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        case .leftBottomToRightTop:
           rect = self.bounds
           v.autoresizingMask = [.flexibleHeight ,.flexibleWidth]
        }
        v.linePostion = position
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.tag = startTag + position.rawValue
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }
    
    func removeLine(in position:XLinePostion) {
        let startTag = 5432
        let res = self.viewWithTag(startTag + position.rawValue)
        if res != nil && res is XLineView {
            res?.removeFromSuperview()
            return
        }
    }
    
    func addLeftVerticalLine(leftInset:CGFloat,lineColor:UIColor = UIColor.white,startInset:CGFloat = 0,endInset:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
        
        if self.autoresizesSubviews == false {
           #if DEBUG
           fatalError("autoresizesSubviews为false会导致添加的线显示异常")
           #else
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           #endif
        }
        
        let tag = String.init(format: "%04d", leftInset) + String.init(format: "%04d", startInset) + String.init(format: "%04d", endInset)
        let startTag = 5432
        if ignoreIfExist {
            let res = self.viewWithTag(startTag + Int(tag)!)
            if res != nil && res is XLineView {
                return
            }
        }

        let position = XLinePostion.left

        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        rect = CGRect(x: leftInset, y: startInset, width: lineWidth, height: self.height - startInset - endInset)
        v.autoresizingMask = [.flexibleHeight,.flexibleRightMargin]
        v.tag = startTag + Int(tag)!
        v.linePostion = position
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }
    
    func addRightVerticalLine(rightInset:CGFloat,lineColor:UIColor = UIColor.white,startInset:CGFloat = 0,endInset:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
        
        if self.autoresizesSubviews == false {
           #if DEBUG
           fatalError("autoresizesSubviews为false会导致添加的线显示异常")
           #else
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           #endif
        }

        let tag = String.init(format: "%04d", rightInset) + String.init(format: "%04d", startInset) + String.init(format: "%04d", endInset)
        let startTag = 5432
        if ignoreIfExist {
            let res = self.viewWithTag(startTag + Int(tag)!)
            if res != nil && res is XLineView {
                return
            }
        }

        let position = XLinePostion.right

        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        rect = CGRect(x: self.width - rightInset - lineWidth, y: startInset, width: lineWidth, height: self.height - startInset - endInset)
        v.autoresizingMask = [.flexibleHeight,.flexibleLeftMargin]
        v.tag = startTag + Int(tag)!
        v.linePostion = position
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }

    func addTopHorizontalLine(topInset:CGFloat,lineColor:UIColor = UIColor.white,startInset:CGFloat = 0,endInset:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
        
        if self.autoresizesSubviews == false {
           #if DEBUG
           fatalError("autoresizesSubviews为false会导致添加的线显示异常")
           #else
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
           #endif
        }
        
        let tag = String.init(format: "%04d", topInset) + String.init(format: "%04d", startInset) + String.init(format: "%04d", endInset)
        let startTag = 5432
        if ignoreIfExist {
           let res = self.viewWithTag(startTag + Int(tag)!)
           if res != nil && res is XLineView {
               return
           }
        }

        let position = XLinePostion.top

        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        rect = CGRect(x: startInset, y: topInset, width: self.width - startInset - endInset, height: lineWidth)
        v.autoresizingMask = [.flexibleWidth ,.flexibleBottomMargin]
        v.tag = startTag + Int(tag)!
        v.linePostion = position
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }

    func addBottomHorizontalLine(bottomInset:CGFloat,lineColor:UIColor = UIColor.white,startInset:CGFloat = 0,endInset:CGFloat = 0,lineWidth:CGFloat = 1,isOnePixelWidth:Bool = false,ignoreIfExist:Bool = true) {
       
        if self.autoresizesSubviews == false {
          #if DEBUG
          fatalError("autoresizesSubviews为false会导致添加的线显示异常")
          #else
          print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
          print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
          print("autoresizesSubviews为false会导致添加的线显示异常，求求你了，这个必须处理")
          #endif
        }
        
        let tag = String.init(format: "%04d", bottomInset) + String.init(format: "%04d", startInset) + String.init(format: "%04d", endInset)
        let startTag = 5432
        if ignoreIfExist {
           let res = self.viewWithTag(startTag + Int(tag)!)
           if res != nil && res is XLineView {
               return
           }
        }

        let position = XLinePostion.bottom

        var rect = CGRect.zero
        let v = XLineView.init(frame: rect)
        rect = CGRect(x: startInset, y: self.height - bottomInset - lineWidth, width: self.width - startInset - endInset, height: lineWidth)
        v.autoresizingMask = [.flexibleWidth ,.flexibleTopMargin]
        v.tag = startTag + Int(tag)!
        v.linePostion = position
        v.lineWidth = lineWidth
        v.isOnePixelWidth = isOnePixelWidth
        v.frame = rect
        v.lineColor = lineColor
        self.addSubview(v)
    }
}

