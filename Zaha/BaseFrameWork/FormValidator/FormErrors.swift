//
//  FormErrors.swift


import UIKit


enum FormError: Error {
    case empty(name : String)
    case onlyAlphabets(name : String )
    case minimumLength(name : String, len : Int)
    case maximumLength(name : String, len : Int)
    case validEmail
    case onlyNumbers
    case shouldAlphaNumeric(name : String)
    case isContainsWhitespace(name : String)
    case unknown
}


extension FormError: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .empty(let name): return "Kindly provide \(name)"
        case .onlyAlphabets(let name): return "\(name) can only contain alphabets"
        case .minimumLength(let name, let val): return "\(name) minimum length should be \(val)"
        case .maximumLength(let name, let val): return "\(name)  maximum length should be \(val)"
        case .validEmail: return "Kindly provide valid email address "
        case .onlyNumbers: return "Kindly provide valid mobile number "
        case .shouldAlphaNumeric(let name) : return "\(name) should contains at least one number and at least one alphabet character"
        case .isContainsWhitespace(let name): return "\(name) should not contain white spaces "
        case .unknown : return "Unknown validation"
        }
    }
}



