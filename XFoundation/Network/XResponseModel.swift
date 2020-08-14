//
//  XResponseModel.swift
//  XFoundation
//
//  Created by sckj on 2020/8/13.
//  Copyright © 2020 com.learn. All rights reserved.
//

import UIKit
import HandyJSON

class XResponseModel<T>: NSObject,HandyJSON {
    var data : T? = nil
    var msg : String = ""
    var code : Int = 0
    
    var page : Int = 1
    var total : Int = 1
    
    override required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.page <-- "current"
        
        mapper <<<
            self.total <-- "pages"
    }
}
