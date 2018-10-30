//
//  debugPrintLog.swift


import Foundation

//func debugPrintLog(_ arg: Any...) {
//
//     debugPrint(arg)
// items.map { "*\($0)" }.joined(separator: separator)
//
//}
let showLogPrint = true
let showLogDebugPrint = true
let showlogConstraint = true

public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    
    if showLogPrint == true {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    }
   // if showlogConstraint {
        UserDefaults.standard.setValue(showlogConstraint, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
   // }
}

func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    
    if showLogDebugPrint == true {
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.debugPrint(output, terminator:terminator)
    }
   // if showlogConstraint {
        UserDefaults.standard.setValue(showlogConstraint, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
   // }
}

func getLocalizedString(_ key : String) -> String {
    
    return NSLocalizedString(key, comment: "")
}

