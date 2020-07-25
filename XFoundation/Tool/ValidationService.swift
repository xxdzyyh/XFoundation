//
//  ViewModelProtocols.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/25.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation

//MARK: - 常用正则表达式

/// 正则表达式：判断是否是十进制数字
/// - Parameter accuracy: 最大精度
public func REPatternDecimal(accuracy: Int) -> String {
    "^[0-9]*.?[0-9]{0,\(accuracy)}$"
}

/// 正则表达式：判断是否符合身份证号格式
let REPatternChinaIDCard = "(^\\d{15}$)|(^\\d{17}([0-9]|X)$)"
/// 输入时判断使用
let REPatternChinaIDCardForInput = "(^\\d{0,15}$)|(^\\d{0,17}([0-9]|X)$)"

/* 正则表达式：判断是否符合手机号格式
 *
 * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
 * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
 * 电信号段: 133,149,153,170,173,177,180,181,189
 * "^[1][3-9][0-9]{9}$"
 */
let REPatternMobilePhoneNumber = "^(\\+\\d{2}-)?(\\d{2,3}-)?([1][3-9][0-9]{9})$"
/// 输入时判断使用
let REPatternMobilePhoneNumberForInput = "^(\\+\\d{0,2}-)?(\\d{0,3}-)?([1][3-9][0-9]{0,9})$"

/// 正则表达式：判断是否符合邮箱地址格式
let REPatternEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"
/// 输入时判断使用
//let REPatternEmailForInput = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

/*
 * 判断是否符合 URL 格式
 * // (https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]
 */
let REPatternURL = "(https?)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]"


// 判断是否是整数
let REPatternInteger = "^\\d+$"

//MARK: - 输入值校验

public func CRIsNullOrEmpty(text: String?) -> Bool {
    if (text as Any) is NSNull {
        return true
    }
    if let string: String = text {
        guard !string.isEmpty && string != "(null)" && string != "<null>" else {
            return true
        }
    } else { return true }
    return false
}

public func CRMatches(pattern: String, text: String?) -> [NSTextCheckingResult]? {
    guard let string = text else { return nil }
    if string.count <= 0 {
        return nil
    }
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        return regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
    }
    return nil
}

public func CRMatch(pattern: String, text: String?) -> NSTextCheckingResult? {
    return CRMatches(pattern: pattern, text: text)?.first
}

public func CRIsMatch(pattern: String, text: String?) -> Bool {
    if CRIsNullOrEmpty(text: text) {
        return false
    }
    if CRMatch(pattern: pattern, text: text) == nil {
        return false
    }
    return true
}

public func CRIsEmail(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternEmail, text: text)
}

/**
 * 判断字符串是否符合手机号码格式
 * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
 * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
 * 电信号段: 133,149,153,170,173,177,180,181,189
 * @param text 待检测的字符串
 * @return 待检测的字符串
 */
public func CRIsPhoneNumber(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternMobilePhoneNumber, text: text)
}

public func CRIsInteger(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternInteger, text: text)
}

public func CRIsURL(text: String?) -> Bool {
    return CRIsMatch(pattern: REPatternURL, text: text)
}

enum ValidationResult {
    case ok(msg: String)
    case empty(msg: String)
    case validating
    case failed(msg: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:   return true
        default:    return false
        }
    }
}

protocol ValidationService {
    func validateUsername(_ username: String) -> ValidationResult
    func validatePassword(_ password: String) -> ValidationResult
    func validatePasswordRepeat(_ password: String, pwdRepeat: String) -> ValidationResult
    func validatePayPwd(_ payPwd: String) -> ValidationResult
    func validateMobilePhone(_ phone: String) -> ValidationResult
    func validateEmail(_ email: String) -> ValidationResult
    func validateMsgCode(_ code: String) -> ValidationResult
    func validateShareCode(_ code: String) -> ValidationResult
    func validateLocalCaptcha(_ input: String, captcha: String) -> ValidationResult
    func validateNickname(_ nickname: String) -> ValidationResult
    func validateIDNumber(_ idNumber: String) -> ValidationResult
}

//MARK: - Default Implementations
extension ValidationService {
    
    func validateUsername(_ username: String) -> ValidationResult {
        let charCount = username.count
        if charCount == 0 {
            return .empty(msg: "请输入用户名")
        }
        return .ok(msg: "")
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let charCount = password.count
        if charCount == 0 {
            return .empty(msg: "请输入密码")
        }
//        if charCount < minPwdCount {
//            return .failed(msg: "Password must be at least \(minPwdCount) characters")
//        }
        return .ok(msg: "")
    }
    
    func validatePasswordRepeat(_ password: String, pwdRepeat: String) -> ValidationResult {
        let charCount = pwdRepeat.count
        if charCount == 0 {
            return .empty(msg: "请再次输入密码")
        }
        if pwdRepeat == password {
            return .ok(msg: "")
        } else {
            return .failed(msg: "两次输入密码不一致")
        }
    }
    
    func validatePayPwd(_ payPwd: String) -> ValidationResult {
        let charCount = payPwd.count
        if charCount == 0 {
            return .empty(msg: "请输入安全密码")
        }
//        if charCount < minPwdCount {
//            return .failed(msg: "Password must be at least \(minPwdCount) characters")
//        }
        return .ok(msg: "")
    }
    
    func validateMobilePhone(_ phone: String) -> ValidationResult {
        let charCount = phone.count
        if charCount == 0 {
            return .empty(msg: "请输入手机号")
        }
        if CRIsPhoneNumber(text: phone) {
            return .ok(msg: "")
        } else {
            return .failed(msg: "请输入正确的手机号")
        }
    }
    
    func validateEmail(_ email: String) -> ValidationResult {
        let charCount = email.count
        if charCount == 0 {
            return .empty(msg: "请输入邮箱")
        }
        if CRIsEmail(text: email) {
            return .ok(msg: "")
        } else {
            return .failed(msg: "请输入正确的邮箱")
        }
    }
    
    func validateMsgCode(_ code: String) -> ValidationResult {
        let charCount = code.count
        if charCount == 0 {
            return .empty(msg: "请输入短信验证码")
        }
        return .ok(msg: "")
    }
    
    func validateShareCode(_ code: String) -> ValidationResult {
        let charCount = code.count
        if charCount == 0 {
            return .empty(msg: "请输入邀请码")
        }
        return .ok(msg: "")
    }
    
    func validateLocalCaptcha(_ input: String, captcha: String) -> ValidationResult {
        let charCount = input.count
        if charCount == 0 {
            return .empty(msg: "请输入验证码")
        }
        if input.compare(captcha, options: .caseInsensitive) == .orderedSame {
            return .ok(msg: "")
        } else {
            return .failed(msg: "验证码错误")
        }
    }
    
    func validateNickname(_ nickname: String) -> ValidationResult {
        let charCount = nickname.count
        if charCount == 0 {
            return .empty(msg: "请输入会员昵称")
        }
        return .ok(msg: "")
    }
    
    func validateIDNumber(_ idNumber : String) -> ValidationResult {
        let count = idNumber.count
        if count == 0 {
            return .empty(msg: "请输入身份证号")
        }
        
        if count != 15 && count != 18 {
            return .failed(msg: "请输入正确的身份证号")
        } else {
            if count == 15 {
                if isPurnInt(string: idNumber) {
                    return .ok(msg: "")
                } else {
                    return .failed(msg: "请输入正确的身份证号")
                }
            } else  {
                let pre = String(idNumber[..<idNumber.index(idNumber.startIndex,offsetBy: 17)])
                let last = idNumber.last!
                
                if last.isNumber {
                    if isPurnInt(string: pre) {
                        return .ok(msg: "")
                    } else {
                        return .failed(msg: "请输入正确的身份证号")
                    }
                } else {
                    if last == "X" || last == "x" {
                        if isPurnInt(string: pre) {
                            return .ok(msg: "")
                        } else {
                            return .failed(msg: "请输入正确的身份证号")
                        }
                    } else {
                        return .failed(msg: "请输入正确的身份证号")
                    }
                }
            }
        }
    }
    
    // 判断输入的字符串是否为数字，不含其它字符
    func isPurnInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
}

class DefaultValidationService: ValidationService {
    
}

//MARK: - Signup Implementations
class SignupValidationService: ValidationService {
    
    // 密码最小长度
    let minPwdCount = 6
    
    func validatePassword(_ password: String) -> ValidationResult {
        let charCount = password.count
        if charCount == 0 {
            return .empty(msg: "请输入密码")
        }
        if charCount < minPwdCount {
            //return .failed(msg: "Password must be at least \(minPwdCount) characters")
            return .failed(msg: "密码长度至少\(minPwdCount)位")
        }
//        if false == CRIsMatch(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d$@$!%*#?&]{8,}$", text: password) {
//            return .failed(msg: "密码至少要包含一个字母和一个数字")
//        }
        return .ok(msg: "")
    }
}

//MARK: - Pay Password Implementations
final class PayPwdValidationService: SignupValidationService {

    // 密码最小长度
    let minPayPwdCount = 6
    
    func validatePayPwd(_ payPwd: String) -> ValidationResult {
        let charCount = payPwd.count
        if charCount == 0 {
            return .empty(msg: "请输入密码")
        }
        if charCount < minPayPwdCount {
            return .failed(msg: "密码长度至少\(minPayPwdCount)位")
        }
        return .ok(msg: "")
    }
}

final class UpdateLoginPasswordValidationService : ValidationService {
    let minPayPwdCount = 6
    
    func validatePayPwd(_ payPwd: String) -> ValidationResult {
        let charCount = payPwd.count
        if charCount == 0 {
            return .empty(msg: "请输入密码")
        }
        if charCount < minPayPwdCount {
            return .failed(msg: "密码长度至少\(minPayPwdCount)位")
        }
        return .ok(msg: "")
    }
}
