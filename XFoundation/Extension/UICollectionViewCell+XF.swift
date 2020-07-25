//
//  UICollectionViewCell+XF.swift
//  XFoundation
//
//  Created by sckj on 2020/7/25.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

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
    
    class func cell(for collectionView:UICollectionView, identifier:String? = nil, indexPath:IndexPath) -> XBaseCollectionViewCell {
        var reuseIdentifier = identifier
        if reuseIdentifier == nil {
           reuseIdentifier = self.className
        }
        /**
            collectionView不能像tableView在没有register的情况下，调用 dequeueReusableCell，调用dequeueReusableCell会crash
         */
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier!, for: indexPath) as! XBaseCollectionViewCell
    }
}
