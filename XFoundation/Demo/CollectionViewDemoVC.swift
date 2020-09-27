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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 3)) {
            self.collectionLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 200)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = XBaseCollectionViewCell.cell(for: collectionView, indexPath: indexPath)
        
        let position = XLinePostion.init(rawValue: indexPath.row) ?? .bottom
        
        print(position)
        
        if position == .left {
            cell.contentView.addLine(position:position, lineColor:.orange, startInset: 10,endInset: 10, lineWidth: 2)
            cell.contentView.addLine(position: .top, lineColor: UIColor.red,lineWidth: 10)
            cell.contentView.addLine(position: .bottom, lineColor: UIColor.red,lineWidth: 10)
        } else if position == .right {
            
            cell.contentView.addRightVerticalLine(rightInset: 20,lineColor: .yellow,lineWidth: 20)
            cell.addLine(position:.right,lineColor: .systemPink, lineWidth: 20)
            
        } else {
            cell.contentView.addLine(position:position, lineColor:.orange,lineWidth: 2)
        }
        
        cell.config(model: dataList[indexPath.row])
        
        return cell
    }
    

}
