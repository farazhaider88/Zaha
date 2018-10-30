//
//  EnterEmailViewController.swift
//

import UIKit

class EnterEmailViewController: UIViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue , nil)
    
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblEnterEmail: BaseUILabel!
    @IBOutlet weak var lblResetPwd: BaseUILabel!
    @IBOutlet weak var txtEmail: BaseUITextField!
    @IBOutlet weak var btnSubmit: CustomButton!
    
    
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var lblHeader: BaseUILabel!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //txtEmail.text = "w@w.com"
        txtEmail.keyboardType = .emailAddress
        setTextAsPerLanguage()
        setupForAnimation()
        perform(#selector(animate), with: nil, afterDelay: 0.2)
    }
    
    
    func setTextAsPerLanguage() {
        lblHeader.text = GlobalStatic.getLocalizedString("forget_pwd")
        btnGoBack.setImage(UIImage.init(named: "backBtn")?.flipIfNeeded(), for: .normal)
        lblEnterEmail.text = GlobalStatic.getLocalizedString("enter_email")
        lblResetPwd.text = GlobalStatic.getLocalizedString("lbl_reset_pwd")
        txtEmail.placeholder = GlobalStatic.getLocalizedString("email_address")
        btnSubmit.setTitle(GlobalStatic.getLocalizedString("submit"), for: .normal)
       
    
    }
    
    func setupForAnimation() {
        imgLogo.isHidden = true
        lblEnterEmail.isHidden = true
        lblResetPwd.isHidden = true
        txtEmail.isHidden = true
        btnSubmit.isHidden = true
    }
    
    @objc func animate(){
        
        // var t = 0.1
        //  var diff = 0.5
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipLabelEnterEmail), with: nil, afterDelay: 0.1)
        perform(#selector(flipLblReset), with: nil, afterDelay: 0.2)
        perform(#selector(flipTxtEmail), with: nil, afterDelay: 0.3)
         perform(#selector(flipBtn), with: nil, afterDelay: 0.4)
        
        // perform(#selector(imgLogo.flipFromRight), with: nil, afterDelay: 0.17)
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
    }
    
    @objc func flipLabelEnterEmail() {
        lblEnterEmail.flipFromRight()
    }
    
    @objc func flipLblReset() {
        lblResetPwd.flipFromRight()
    }
    @objc func flipTxtEmail(){
        txtEmail.flipFromRight()
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
    
   
    @IBAction func submitButtonTapped(_ sender: Any) {
        let status = validateForm()
        
        if status.0 == false {
            Alert.showMsg(msg: status.1)
            
        }else {
            
            getCode(email: txtEmail.text!)
        }
    }
    
    func validateForm() -> (Bool , String)  {
        
        let emailText = txtEmail.text
       if (emailText?.isEmptyStr())!{
            return (false, "Kindly provide email address")
        }else if !(emailText?.isValidEmail())!{
            return (false, "Kindly provide a valid email address")
        }
        
        return (true, "")
    }
    
}
// MARK: - Networking
extension EnterEmailViewController{
    
    func getCode(email : String) {
        
        router.goToEnterCodeVC(from: self, codeType : .forgetPwd)
     }
    
}
