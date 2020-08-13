//
//  XTableViewCell.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/26.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit
import RxSwift

/// <#Description#>
public class XBaseTableCell: UITableViewCell {

    var data : Any?
    
    //MARK: - 数据填充
    
   func config(model:Any) {
        
    }
    
    /// 避免重复注册监听
    /// ViewController.swift
    /// cell.button.rx.tap.asDriver().drive(onNext: { [weak se
    ///     ...
    /// })..disposed(by: cell.prepareForReuseDisposeBag)
    var prepareForReuseDisposeBag = DisposeBag()
    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
}
