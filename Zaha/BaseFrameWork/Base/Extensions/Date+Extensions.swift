//
//  Date+Extensions.swift


import UIKit
import MOLH
extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
         dateFormatter.locale = Locale(identifier:"en")
        return dateFormatter.string(from: self)
    }
    
    func toString(_ withCustomeFormat : String? = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:"en")
        dateFormatter.dateFormat = withCustomeFormat
        return dateFormatter.string(from: self)
    }
    
 
}
