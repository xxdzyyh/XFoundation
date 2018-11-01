//
//  XDateExtension.swift
//  XFoundation
//
//  Created by xiaoniu on 2018/10/31.
//  Copyright © 2018年 com.learn. All rights reserved.
//

import UIKit

extension Date {
    
    /// "yyyy-MM-dd HH:mm:ss" -> "yyyy年MM月dd日"
    ///
    /// - Parameter dateString: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: "yyyy年MM月dd日"
    static func stringToYearMonthDay(dateString: String) -> (String?) {
        
        let formatter = DateFormatter.init()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date : Date? = formatter.date(from: dateString)
        
        if date == nil {
            return nil
        } else {
            formatter.dateFormat = "yyyy年MM月dd日"
            
            return formatter.string(from: date!)
        }
    }
    
    /// "yyyy-MM-dd HH:mm:ss" 和现在进行比较，得出日常生活表达，如“1分钟”
    ///
    /// - Parameter timeString: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: 日常生活表达
    static func liveTimeAgo(timeString:String) -> (String?) {
        
        let date = Date.date(defaultFormatTime: timeString)
        
        if date == nil {
            return nil
        } else {
            return Date.init().liveTimeAgo(date: date!)
        }
    }
    
    /// 时间字符串转成Date
    ///
    /// - Parameter defaultFormatTime: "yyyy-MM-dd HH:mm:ss"
    /// - Returns: 时间字符串对应的Date对象
    static func date(defaultFormatTime:String) -> (Date?) {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: defaultFormatTime)
    }
    
    func liveTimeAgo(time:String) -> (String?) {
        let date = Date.date(defaultFormatTime: time) 
        
        if date != nil {
            return self.liveTimeAgo(date: date!)
        } else {
            return nil
        }
    }
    
    /// 求取两个时间之间的间隔，转换为日常生活中通用的表达
    ///
    /// - Parameter date: 要比较的时间
    /// - Returns: 日常生活表达
    func liveTimeAgo(date: Date) -> (String) {
        
        let deltaSeconds = self.timeIntervalSince(date)
        let deltaMinutes = deltaSeconds/60.0;
        
        if deltaSeconds < 120 {
            return "1分钟"
        } else if (deltaMinutes < 60) {
            return String.init(format: "%.0f分钟", deltaMinutes)
        } else if (deltaMinutes < 120) {
            return "1小时"
        } else if (deltaMinutes < (24 * 60)) {
            return String.init(format: "%.0f小时", deltaMinutes/60);
        } else if (deltaMinutes < (24 * 60 * 7)) {
            return String.init(format: "%.0f天", deltaMinutes/(60 * 24));
        } else if (deltaMinutes < (24 * 60 * 14)) {
            return "上周";
        } else if (deltaMinutes < (24 * 60 * 31)) {
            return String.init(format: "%.0f周", deltaMinutes/(60 * 24 * 7));
        } else if (deltaMinutes < (24 * 60 * 61)) {
            return "上个";
        } else if (deltaMinutes < (24 * 60 * 365.25)) {
            return String.init(format: "%.0f月", deltaMinutes/(60 * 24 * 30));
        } else if (deltaMinutes < (24 * 60 * 731)) {
            return "去年";
        } else {
            return String.init(format: "%d.f", deltaMinutes/(60 * 24 * 365))
        }
    }
    
}
