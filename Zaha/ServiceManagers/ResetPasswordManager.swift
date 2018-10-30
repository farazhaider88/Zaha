

import Foundation
import Alamofire

class ResetPasswordManager: AFManagerProtocol {
    var isSuccess = false
    var message = ""
    
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
                    self.message = model.message!
                    
                    
                    
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

extension ResetPasswordManager {
    // parameters : [String : AnyObject]
    func params(oldPass : String, newPass : String) -> AFParam {
        
        let headers: [String : String] = ["Authorization": "Bearer \(CurrentUser.token)"]
        
        let parameters = [
            "user_id": CurrentUser.data!.id,
            "old_password": oldPass,
            "password":newPass,
        ] as [String : AnyObject]
        
        let param = AFParam(endpoint: "reset-password", params:parameters , headers: headers, method: .post, parameterEncoding: JSONEncoding.default, images: [])
        
        return param
    }
}
