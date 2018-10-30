//
//  UserManager.swift
//  Zaha
//
//  Created by muzamilhassan on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit
import Alamofire


class UserManager
{
    var isSuccess = false
    var userData : User?
    
    
    
    func apiUpdateNotification(userID : Int, isNotification : String, completion: @escaping (User) -> Void)
    {
        let parameters = [
            "user_id" : userID,
            "is_notification" : isNotification
            ] as [String : AnyObject]
        
        self.isSuccess = false
        let headers: [String:String] = [:]
        
        let param = AFParam(endpoint: "user/togglenotification", params: parameters, headers: headers, method: .post, parameterEncoding: URLEncoding.default, images: [])
        
        //request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do
            {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GenericServerResponse<User>.self, from: data)
                
                if data.response == ServiceCodes.successCode
                {
                    self.isSuccess = true
                    
                    //--ww    self.modelArray = data.result!
                    
                    completion(data.result!)
                    
                }
                else
                {
                    AlertMessages.showError(msg : data.message ?? "Server Not responding")
                    
                    
                }
            }
            catch let error
            {
                print("Error: ", error)
            }
            
        }) { (error) in
            
        }
        
    }
    
    
    
}
