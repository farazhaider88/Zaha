//
//  Storyboards.swift
//

import Foundation
import UIKit

public enum Storyboards : String {
    
    // As enum is extends from String then its case name is also its value
    case main = "Main"
    case walkthrough = "Walkthrough"
    case registeration = "LoginMoule"
    case home = "HomeModule"
    case setting = "Settings"
    case sideMenu = "SideMenu"
    case upcomingExperience = "UpcommingExperienceModule"
   
    
}

enum Navigation {
    static var currentNavigation  : UINavigationController?  = nil
}

;
