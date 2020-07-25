//
//  CollectionViewDemoVC.swift
//  XFoundation
//
//  Created by sckj on 2020/7/25.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit

class CollectionViewDemoVC: XBaseCollectionVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataList = ["0","1","2","3","4","5","6"]
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = XBaseCollectionViewCell.cell(for: collectionView, indexPath: indexPath) as! XBaseCollectionViewCell
        
        let position = XLinePostion.init(rawValue: indexPath.row) ?? .bottom
        
        print(position)
        
        cell.contentView.addLine(position:position, lineColor:.orange,lineWidth: 2)
        cell.config(model: dataList[indexPath.row])
        
        return cell
    }
    

}
