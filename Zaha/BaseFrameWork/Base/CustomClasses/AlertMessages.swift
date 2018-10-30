//
//  AlertClass.swift
//  VIE
//
//  Created by Waqas Ali on 8/7/18.
//  Copyright © 2018 aurangzaibkhan. All rights reserved.
//

import UIKit
import SwiftMessages

class AlertMessages {
    
    public static func showSuccess(title : String =  "Alert" , msg : String) {
    
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureContent(title: title, body: msg, iconText: "")
    view.configureTheme(.success, iconStyle: .default)
    view.button?.isHidden = true
    view.configureDropShadow()
    SwiftMessages.show(view: view)
    }
    
    
    public static func showError(title : String =  "Alert" , msg : String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: title, body: msg, iconText: "")
        view.configureTheme(.error, iconStyle: .default)
        view.button?.isHidden = true
        view.configureDropShadow()
        SwiftMessages.show(view: view)
    }
}

