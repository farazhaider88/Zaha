//
//  ResetPasswordViewController.swift
//

import UIKit

class ResetPasswordViewController: BaseViewController , StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.setting.rawValue, nil)
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtOldPwd: BaseUITextField!
    @IBOutlet weak var txtNewPwd: BaseUITextField!
    @IBOutlet weak var txtConfirmPwd: BaseUITextField!
    @IBOutlet weak var btnSubmit: CustomButton!
    var manager = ResetPasswordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = GlobalStatic.getLocalizedString("change_pwd")
        txtOldPwd.placeholder = GlobalStatic.getLocalizedString("current_pwd")
        txtNewPwd.placeholder = GlobalStatic.getLocalizedString("new_pwd")
        txtConfirmPwd.placeholder = GlobalStatic.getLocalizedString("confirm_pwd")
        btnSubmit.setTitle(GlobalStatic.getLocalizedString("submit"), for: .normal)
        setupForAnimation()
        perform(#selector(animate), with: nil, afterDelay: 0.2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupForAnimation() {
        
        imgLogo.isHidden = true
        txtOldPwd.isHidden = true
        txtNewPwd.isHidden = true
        txtConfirmPwd.isHidden = true
        btnSubmit.isHidden = true
    }
    
    @objc func animate(){
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipOldPwd), with: nil, afterDelay: 0.1)
        perform(#selector(flipPwd), with: nil, afterDelay: 0.2)
        perform(#selector(flipConfirmPwd), with: nil, afterDelay: 0.3)
        perform(#selector(flipBtnSubmit), with: nil, afterDelay: 0.4)
      
        
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
    }
    
    @objc func flipOldPwd() {
        txtOldPwd.flipFromRight()
    }
    @objc func flipPwd() {
        txtNewPwd.flipFromRight()
    }
    @objc func flipConfirmPwd(){
        txtConfirmPwd.flipFromRight()
    }
    
    @objc func flipBtnSubmit() {
        btnSubmit.flipFromRight()
    }
    
  

    @IBAction func submitBtnPressed(_ sender: Any) {
        let status = validateForm()
        
        if status.0 == false {
            Alert.showMsg(msg: status.1)
            
        }else {
            resetPwd(oldPwd: txtOldPwd.text!, newPwd: txtNewPwd.text!)
          }
    }
   

    
    func validateForm() -> (Bool , String)  {
        
        let oldPwd = txtOldPwd.text
        let pwdText = txtNewPwd.text
        let confirmPwd = txtConfirmPwd.text
        
        if (oldPwd?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("old_pwd_needed"))
          }else if (pwdText?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("new_pwd_needed"))
        }else if (pwdText?.isContainsWhitespace)! {
            return (false, GlobalStatic.getLocalizedString("pwd_space"))
        }else if (pwdText?.count)! < Constants.minimumLengthPwd || (pwdText?.count)! > Constants.maximumLengthPwd {
            return (false, "\(GlobalStatic.getLocalizedString("pwd_min"))  \(Constants.minimumLengthPwd) \(GlobalStatic.getLocalizedString("pwd_max")) \(Constants.maximumLengthPwd) \(GlobalStatic.getLocalizedString("characters"))")
        }else if (pwdText?.elementsEqual(oldPwd!))! {
            return (false, GlobalStatic.getLocalizedString("new_old_same"))
        }else if !(confirmPwd?.elementsEqual(pwdText!))! {
            return (false, GlobalStatic.getLocalizedString("pwd_not_matched"))
        }
        return (true, "")
    }
    
}

extension ResetPasswordViewController{
    
    func resetPwd(oldPwd : String , newPwd : String) {
        
        
        let requestParam = self.manager.params(oldPass: oldPwd,  newPass: newPwd )
        
        self.manager.api(requestParam, completion: {
            
            if self.manager.isSuccess {
                //self.manager.message ??
                Alert.showWithCompletion(msg:  "Your Password has been changed  successfully!", completionAction: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            else {
                
            }
        })
    }
}
