//
//  TermsManager.swift
//

import Foundation
import Alamofire

class TermsManager: AFManagerProtocol {
    
    
    var isSuccess = false
    var htmlString = ""
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
      
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(CMSTerms.self, from: data)
                
                //check success case from server
                if model.code == ServiceCodes.successCode {
                    self.isSuccess = true
                    
                     let str = "<div style=\"color:#5A5A5A; font-size: \(DesignUtility.getFontSize(fSize: 18))px\"><font face=\"HelveticaNeue\">\(model.result?.crm?.body ?? "<p>html</p>")</font></div>"
                    self.htmlString = str
                    
                }else{
                    Alert.showMsg(msg: model.message ?? "Server not responding")
                }
                
            } catch let err {
                
                print("Err", err)
            }
            
            completion()
        }) { (error) in
            
            completion()
        }
    }
}

extension TermsManager {
   // parameters : [String : AnyObject]
    func params() -> AFParam {
        
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "get-cms", params: ["type": "terms" as AnyObject], headers: headers, method: .post, parameterEncoding: JSONEncoding.default, images: [])
        
        return param
    }
}


