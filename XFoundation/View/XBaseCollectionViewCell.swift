//
//  XBaseCollectionViewCell.swift
//  SPARKVIDEO
//
//  Created by sckj on 2020/7/15.
//

import UIKit
import RxSwift

class XBaseCollectionViewCell: UICollectionViewCell {
    var data : Any?
    
    func config(model:Any) {
        self.data = model
    }
    
    /// 避免重复注册监听
    /// ViewController.swift
    /// cell.button.rx.tap.asDriver().drive(onNext: { [weak se
    ///     ...
    /// })..disposed(by: cell.prepareForReuseDisposeBag)
    lazy var prepareForReuseDisposeBag = DisposeBag()
    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareForReuseDisposeBag = DisposeBag()
    }
}
