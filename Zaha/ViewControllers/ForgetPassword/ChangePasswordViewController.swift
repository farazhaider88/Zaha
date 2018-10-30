//
//

import UIKit

class ChangePasswordViewController: UIViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblChangePwd: BaseUILabel!
    @IBOutlet weak var txtNewPwd: BaseUITextField!
    @IBOutlet weak var txtConfirmPwd: BaseUITextField!
    @IBOutlet weak var btnSubmit: CustomButton!
    
    
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var lblHeader: BaseUILabel!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTextAsPerLanguage()
        setupForAnimation()
        perform(#selector(animate), with: nil, afterDelay: 0.2)
    }
    
    func setTextAsPerLanguage() {
        lblHeader.text = GlobalStatic.getLocalizedString("forget_pwd")
        btnGoBack.setImage(UIImage.init(named: "backBtn")?.flipIfNeeded(), for: .normal)
        lblChangePwd.text = GlobalStatic.getLocalizedString("change_pwd")
        txtNewPwd.placeholder =  GlobalStatic.getLocalizedString("new_pwd")
        txtConfirmPwd.placeholder =  GlobalStatic.getLocalizedString("confirm_pwd")
        btnSubmit.setTitle( GlobalStatic.getLocalizedString("submit"), for: .normal)
        
        btnGoBack.isHidden = true
    }
    
    func setupForAnimation() {
        imgLogo.isHidden = true
        lblChangePwd.isHidden = true
        txtNewPwd.isHidden = true
        txtConfirmPwd.isHidden = true
        btnSubmit.isHidden = true
    }
    
    @objc func animate(){
        
        // var t = 0.1
        //  var diff = 0.5
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipLabelChangePwd), with: nil, afterDelay: 0.1)
        perform(#selector(flipTxtNewPwd), with: nil, afterDelay: 0.2)
        perform(#selector(flipTxtConfirmPwd), with: nil, afterDelay: 0.3)
        perform(#selector(flipBtn), with: nil, afterDelay: 0.4)
        
        // perform(#selector(imgLogo.flipFromRight), with: nil, afterDelay: 0.17)
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
    }
    
    @objc func flipLabelChangePwd() {
      lblChangePwd.flipFromRight()
    }
    
    @objc func flipTxtNewPwd() {
     txtNewPwd.flipFromRight()
    }
    @objc func flipTxtConfirmPwd(){
        txtConfirmPwd.flipFromRight()
    }
    
    @objc func flipBtn(){
        btnSubmit.flipFromRight()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        }

    @IBAction func submitBtnPressed(_ sender: Any) {
        let status = validateForm()
        if status.0 == false {
            Alert.showMsg(msg: status.1)
            
        }else {
            
            resetPwd(password:txtNewPwd.text!, cPassword: txtConfirmPwd.text!  )
            
           
        }
    }
    
    func validateForm() -> (Bool , String)  {
        
      
        let pwdText = txtNewPwd.text
        let confirmPwd = txtConfirmPwd.text
        if (pwdText?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("new_pwd_needed"))
        }else if (pwdText?.isContainsWhitespace)! {
            return (false, GlobalStatic.getLocalizedString("pwd_space"))
        }else if (pwdText?.count)! < Constants.minimumLengthPwd || (pwdText?.count)! > Constants.maximumLengthPwd {
            return (false, "\(GlobalStatic.getLocalizedString("pwd_min"))  \(Constants.minimumLengthPwd) \(GlobalStatic.getLocalizedString("pwd_max")) \(Constants.maximumLengthPwd) \(GlobalStatic.getLocalizedString("characters"))")
        }else if !(confirmPwd?.elementsEqual(pwdText!))! {
            return (false, GlobalStatic.getLocalizedString("pwd_not_matched"))
        }
        return (true, "")
    }
}

// MARK: - Networking
extension ChangePasswordViewController{
    
    func resetPwd(password : String , cPassword : String) {
        
       }
}
