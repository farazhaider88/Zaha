

import Foundation
import Alamofire

class RegisterManager: AFManagerProtocol {
    
    
    var isSuccess = false
    var message  = ""
    var userData : User?
    
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
        //set default value
       
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(RegisterModel.self, from: data)
                
                //check success case from server
                if model.code == ServiceCodes.successCode {
                    self.isSuccess = true
                    self.message = model.message ?? "To complete the registration process, we have sent you a verification code on your email"
                   self.userData =  model.result?.user
                   
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

extension RegisterManager {
    
    func params(parameters : [String : AnyObject]) -> AFParam {
        
        let headers: [String : String] = [:]
        
        let param = AFParam(endpoint: "register", params: parameters, headers: headers, method: .post, parameterEncoding:JSONEncoding.default, images: [])
         return param
    }
}


