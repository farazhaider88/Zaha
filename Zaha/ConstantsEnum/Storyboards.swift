//
//  Storyboards.swift
//

import Foundation
import UIKit

public enum Storyboards : String {
    
    // As enum is extends from String then its case name is also its value
    case main = "Main"
    case walkthrough = "Walkthrough"
    case registeration = "Registeration"
    case home = "Home"
    case setting = "Settings"
   
    
}

enum Navigation {
    static var currentNavigation  : UINavigationController?  = nil
}

;
