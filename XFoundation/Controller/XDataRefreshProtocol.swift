//
//  XDataRefreshProtocol.swift
//  XFoundation
//
//  Created by sckj on 2020/8/13.
//  Copyright © 2020 com.learn. All rights reserved.
//

import Foundation
import RxSwift

protocol XDataRefreshProtocol : NSObject {
    associatedtype Data
    
    var dataList : [Data] { get set }
    var page : Int { get set }
    var pageSize : Int { get set }
    
    /// 是否有数据没有加载
    var hasMoreData : Bool { get set }
    
    /// 刷新数据完成，通知视图刷新
    var didRefreshSubject: PublishSubject<()> { get }
    
    /// 加载更多完成，通知视图刷新
    var didLoadMoreSubject: PublishSubject<Range<Int>> { get }
    
    /// 请求完成了，不区分是刷新还是加载更多
    var requestFinishSubject: PublishSubject<()> { get }
    
    func requestData() -> Single<XResponseModel<[Data]>>
}

extension XDataRefreshProtocol {
    
    /// 默认一页30条数据
    var pageSize : Int { 30 }
 
    func refreshData() {
        self.page = 1
        sendRequest()
    }
    
    func sendRequest() {
        let request = requestData()
        request.subscribe(onSuccess: { [weak self] (resp) in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.page == 1 {
                strongSelf.dataList.removeAll()
            }
            let list = resp.data ?? []
            strongSelf.dataList.append(contentsOf: list)
//            strongSelf.hasMoreData = list.count > 
        }) { (error) in
            
        }.disposed(by: self.disposeBag)
    }
    

}
