
import Foundation
import Alamofire
import RealmSwift

class LoginManager: AFManagerProtocol {
    
    
    var isSuccess = false

    var userData : User?
    let realm = try! Realm()
    
    
    func api(_ param: AFParam, completion: @escaping () -> Void) {
        
      
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LoginModel.self, from: data)
                
                //check success case from server
                if model.code == ServiceCodes.successCode {
                    self.isSuccess = true
                    
                    self.userData = model.result?.user
                   
                    
//                     try! self.realm.write({
//                           self.realm.add((model.result?.user)!, update: true)
//                        })
//                         let res = self.realm.objects(User.self)
                     // print("User" , res)
                    
                    
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
    
    
    
    func apiLogOut(_ param: AFParam, completion: @escaping () -> Void) {
        
   
        self.isSuccess = false
        
        //Request
        AFNetwork.shared.apiRequest(param, isSpinnerNeeded: true, success: { (response) in
            
            guard let data = response else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(LoginModel.self, from: data)
                
                //check success case from server
                if model.code == ServiceCodes.successCode {
                    self.isSuccess = true
                    
                    
               
                    
                    
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


extension LoginManager {
    
    func params(parameters : [String : AnyObject]) -> AFParam {
        
        let headers: [String : String] = [:]
  
        let param = AFParam(endpoint: "login", params: parameters, headers: headers, method: .post, parameterEncoding: JSONEncoding.default, images: [])
        
        return param
    }
    
    func paramsLogout() -> AFParam {
        
        let headers: [String : String] = ["Authorization": "Bearer \(CurrentUser.token)"]
        let param = AFParam(endpoint: "logout", params: ["device_token" : CurrentUser.deviceToken as AnyObject], headers: headers, method: .post, parameterEncoding: JSONEncoding.default, images: [])
        
        return param
    }
}


