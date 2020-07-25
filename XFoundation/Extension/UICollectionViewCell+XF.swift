//
//  UICollectionViewCell+XF.swift
//  XFoundation
//
//  Created by sckj on 2020/7/25.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit
import SwiftTryCatch

extension UICollectionViewCell {
    
    class func register(for collectionView:UICollectionView, identifier:String? = nil) {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
           reuseIdentifier = self.className
        }
        let classBundle = Bundle.init(for: self)
        let path = classBundle .path(forResource: className, ofType: "nib")
        if path != nil {
            let nib = UINib(nibName: self.className, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier!)
        } else {
            collectionView.register(self, forCellWithReuseIdentifier: reuseIdentifier!)
        }
    }
    
    class func cell(for collectionView:UICollectionView, identifier:String? = nil, indexPath:IndexPath) -> UICollectionViewCell {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
           reuseIdentifier = self.className
        }
        /**
            collectionView在没有register的情况下，调用 dequeueReusableCell会crash，
            tableView不会，所以tableView可以先dequeueReusableCell，为nil 再去register
            解决crash的方法也很简单，使用try catch 就可以，如果catch到异常，注册一下，下次就不会有异常了
         */
        /**
             使用swift的do catch 无法捕获这个异常，但是使用oc的 @try 可以
         */
//        do {
//            let cell = try collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath) as! XBaseCollectionViewCell
//
//            return cell
//        } catch {
//            self.register(for: collectionView)
//             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath) as! XBaseCollectionViewCell
//
//            return cell
//        }
        
        var cell : UICollectionViewCell?
        SwiftTryCatch.try({
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath)
        }, catch: { (exception) in
            self.register(for: collectionView)
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath)
        }, finally: nil)
        
        return cell!
    }
}
