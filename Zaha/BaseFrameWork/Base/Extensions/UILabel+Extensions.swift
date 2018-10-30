//
//  UILabel+Extensions.swift


import UIKit
extension UILabel {
    
    func animate(newText: String, characterDelay: TimeInterval) {
        
        DispatchQueue.main.async {
            
            self.text = ""
            
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                }
            }
        }
    }
    
}

//let task = DispatchWorkItem { print("do something") }
//
//// execute task in 2 seconds
//DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: task)
//
//// optional: cancel task
//task.cancel()

