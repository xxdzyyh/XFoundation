//
//  TwoButtonSegmentControl.swift
//  ZJVideo
//
//  Created by sckj on 2020/8/6.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TwoButtonSegmentControl: UIView {

    // didSet在init期间不会被调用
    var leftTitle : String? {
        didSet {
            self.leftButton.setTitle(leftTitle, for: .normal)
        }
    }
    
    var rightTitle : String? {
        didSet {
            self.rightButton.setTitle(rightTitle, for: .normal)
        }
    }
    
    var selectColor : UIColor?
    var normalColor : UIColor?
    
    var selectTextColor : UIColor? {
        didSet {
            self.leftButton.setTitleColor(selectTextColor, for: .selected)
            self.rightButton.setTitleColor(selectTextColor, for: .selected)
        }
    }
    
    var normalTextColor : UIColor? {
        didSet {
            self.leftButton.setTitleColor(normalTextColor, for: .normal)
            self.rightButton.setTitleColor(normalTextColor, for: .normal)
        }
    }
    
    var selectFont : UIFont?
    var normalFont : UIFont?
    
    lazy var animationView : CALayer = {
        let layer = CALayer()
        layer.backgroundColor = self.selectColor?.cgColor
        layer.isHidden = true
        return layer
    }()
    
    var selectedIndex : Int = 0
    var selectedIndexSubject: PublishSubject<Int> = PublishSubject<Int>()
    
    required init(leftTitle:String,rightTitle:String,normalColor:UIColor,selectColor:UIColor,normalTextColor : UIColor,selectTextColor : UIColor,normalFont:UIFont? = UIFont.pingFangMedium(ofSize: 15),selectFont:UIFont? = UIFont.pingFangMedium(ofSize: 15)) {
        super.init(frame:CGRect.zero)
        
        self.selectColor = selectColor
        self.normalColor = normalColor
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.selectTextColor = selectTextColor
        self.normalTextColor = normalTextColor
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup() 
    }
    
    func setup() {
        self.addSubview(self.leftButton)
        self.addSubview(self.rightButton)
        
        self.leftButton.setTitleColor(selectTextColor, for: .selected)
        self.rightButton.setTitleColor(selectTextColor, for: .selected)
        self.leftButton.setTitleColor(normalTextColor, for: .normal)
        self.rightButton.setTitleColor(normalTextColor, for: .normal)
        self.leftButton.setTitle(leftTitle, for: .normal)
        self.rightButton.setTitle(rightTitle, for: .normal)
        
        self.leftButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
        }
        
        self.rightButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(self.leftButton.snp.width)
            make.left.equalTo(self.leftButton.snp.right)
        }
        
        let buttons = [self.leftButton, self.rightButton]
        Observable.from(
            buttons.map({ button in
                button.rx.tap.map { button }
            })
        ).merge().subscribe(onNext: { [weak self] (button) in
            button.isSelected = true
            if button.tag == 0 {
                self?.rightButton.isSelected = false
            } else {
                self?.leftButton.isSelected = false
            }
            self?.selectedIndexSubject.onNext(button.tag)
            self?.updateButtonBackgroundColor()
        }).disposed(by: self.disposeBag)
        
        self.leftButton.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    func updateButtonBackgroundColor() {
        if self.leftButton.isSelected {
            self.leftButton.backgroundColor = selectColor
            self.rightButton.backgroundColor = normalColor
            self.leftButton.titleLabel?.font = selectFont
            self.rightButton.titleLabel?.font = normalFont
        } else {
            self.leftButton.backgroundColor = normalColor
            self.rightButton.backgroundColor = selectColor
            self.leftButton.titleLabel?.font = normalFont
            self.rightButton.titleLabel?.font = selectFont
        }
    }
    
//    func
    
    lazy var leftButton: UIButton = {
        let v = UIButton(type: .custom)
        v.tag = 0
        return v
    }()
    
    lazy var rightButton: UIButton = {
        let v = UIButton(type: .custom)
        v.tag = 1
        return v
    }()
}
