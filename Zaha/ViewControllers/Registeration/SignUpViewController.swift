
import UIKit
import MICountryPicker
import MOLH

class SignUpViewController: UIViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) =  (Storyboards.registeration.rawValue, nil)
    
    
    // Mark iboutlets
    
    
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var btnAcceptTerms: BaseUIButton!
    @IBOutlet weak var txtName: BaseUITextField!
    @IBOutlet weak var txtEmail: BaseUITextField!
    
    @IBOutlet weak var txtCode: BaseUITextField!
    @IBOutlet weak var txtNumber: BaseUITextField!
    @IBOutlet weak var txtPwd: BaseUITextField!
    
    @IBOutlet weak var txtConfirmPwd: BaseUITextField!
    var isAccepted = false
    
    @IBOutlet weak var btnSignup: CustomButton!
    
    
    
    @IBOutlet weak var btnGoBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        txtEmail.keyboardType = .emailAddress
        setupForAnimation()
        setTextAsPerLanguage()
        perform(#selector(animate), with: nil, afterDelay: 0.2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTextAsPerLanguage() {
        
        
        txtName.placeholder = GlobalStatic.getLocalizedString("name")
        txtEmail.placeholder = GlobalStatic.getLocalizedString("email_address")
        txtCode.placeholder = GlobalStatic.getLocalizedString("code")
        txtNumber.placeholder = GlobalStatic.getLocalizedString("number")
        txtPwd.placeholder = GlobalStatic.getLocalizedString("pwd")
        txtConfirmPwd.placeholder = GlobalStatic.getLocalizedString("confirm_pwd")
        btnAcceptTerms.setTitle(GlobalStatic.getLocalizedString("accept_terms"), for: .normal)
        btnSignup.setTitle(GlobalStatic.getLocalizedString("signup"), for: .normal)
        let img = UIImage.init(named: "backBtn")?.flipIfNeeded()
        btnGoBack.setImage(img, for: .normal)
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            btnAcceptTerms.spaceValue = 40
        }else{
            btnAcceptTerms.spaceValue = 160
            //--ww btnAcceptTerms.titleLabel?.textAlignment = .right
        }
    }
    
    func setupForAnimation() {
        
        imgLogo.isHidden = true
        txtName.isHidden = true
        txtEmail.isHidden = true
        txtCode.isHidden = true
        txtNumber.isHidden = true
        txtPwd.isHidden = true
        txtConfirmPwd.isHidden = true
        btnAcceptTerms.isHidden = true
        btnSignup.isHidden = true
    }
    
    @objc func animate(){
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipName), with: nil, afterDelay: 0.1)
        perform(#selector(flipEmail), with: nil, afterDelay: 0.2)
        perform(#selector(flipCode), with: nil, afterDelay: 0.3)
        perform(#selector(flipPwd), with: nil, afterDelay: 0.4)
        perform(#selector(flipConfirmPwd), with: nil, afterDelay: 0.5)
        perform(#selector(flipBtnAcceptTerms), with: nil, afterDelay: 0.6)
        perform(#selector(flipBtnSignup), with: nil, afterDelay: 0.7)
        
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
    }
    
    @objc func flipName() {
        txtName.flipFromRight()
    }
    
    @objc func flipEmail() {
        txtEmail.flipFromRight()
    }
    
    
    @objc func flipCode() {
        txtCode.flipFromRight()
        txtNumber.flipFromRight()
    }
    @objc func flipPwd() {
        txtPwd.flipFromRight()
    }
    @objc func flipConfirmPwd(){
        txtConfirmPwd.flipFromRight()
    }
    
    @objc func flipBtnAcceptTerms() {
        btnAcceptTerms.flipFromRight()
    }
    
    @objc func flipBtnSignup(){
        btnSignup.flipFromRight()
    }
    
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func acceptTermsButtonTapped(_ sender: Any) {
        
        if isAccepted == false {
            
            isAccepted = true
            
            btnAcceptTerms .setImage(UIImage.init(named: "checkbox-sel"), for: .normal)
        }else{
            isAccepted = false
            btnAcceptTerms .setImage(UIImage.init(named: "checkbox"), for: .normal)
        }
        
    }
    
    
    @IBAction func showCode(_ sender: Any) {
        showCountryPicker()
    }
    
    func showCountryPicker() {
        let picker = MICountryPicker()
        picker.showCallingCodes = true
        
        picker.didSelectCountryWithCallingCodeClosure = { name, code, dialCode in
            print(dialCode)
            self.txtCode.text = dialCode
            
            self.dismiss(animated: true, completion: {
            })
        }
        
        let vc = UINavigationController.init(rootViewController: picker)
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(dismissPicker))
        picker.navigationItem.leftBarButtonItem = backButton
        self.present(vc, animated: true) {}
    }
    
    @objc func dismissPicker() {
        self.dismiss(animated: true, completion: {
        })
    }
    @IBAction func signupBtnTapped(_ sender: Any) {
        let status = validateForm()
        
        if status.0 == false {
            Alert.showMsg(msg: status.1)
            
        }else {
            
            let parameters = [
                "name" : txtName.text!,
                "email" : txtEmail.text!,
                "password" :txtPwd.text!,
                "password_confirmation" :txtConfirmPwd.text!,
                "phone" : txtCode.text! + "-" + txtNumber.text!,
                "device_type" : "ios",
                "device_token" : CurrentUser.deviceToken,
                ] as [String : String]
            
            
            doRegister(params: parameters)
        }
    }
    
    func validateForm() -> (Bool , String)  {
        
        let nameText = txtName.text
        let emailText = txtEmail.text
        let code = txtCode.text
        let number = txtNumber.text
        let pwdText = txtPwd.text
        let confirmPwd = txtConfirmPwd.text
        
        if (nameText?.isEmptyStr())!{
            return (false, GlobalStatic.getLocalizedString("name_needed"))
        }else if !(nameText?.isAlphabetOnly)!{
            return (false,  GlobalStatic.getLocalizedString("valid_name_needed"))
        }else if (nameText?.count)! < Constants.minimumLengthName {
            return (false,  GlobalStatic.getLocalizedString("name_min"))
        }else if (emailText?.isEmptyStr())!{
            return (false,  GlobalStatic.getLocalizedString("email_needed"))
        }else if !(emailText?.isValidEmail())!{
            return (false,  GlobalStatic.getLocalizedString("valid_email_needed"))
        }else if (code?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("country_code_needed"))
        }else if (number?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("mobile_needed"))
        }else if !((number?.isNumeric())!){
            return (false, GlobalStatic.getLocalizedString("valid_mobile_needed"))
        }else if (number?.hasPrefix("0"))! {
            return (false, GlobalStatic.getLocalizedString("remove_0"))
        }else if (number?.count)! < Constants.minimumLengthNumber || (number?.count)! > Constants.maximumLengthNumber {
            return (false, "\(GlobalStatic.getLocalizedString("number_min"))  \(Constants.minimumLengthNumber) \(GlobalStatic.getLocalizedString("number_max")) \(Constants.maximumLengthNumber)  \(GlobalStatic.getLocalizedString("digits_long"))")
        }else if (pwdText?.isEmptyStr())! {
            return (false, GlobalStatic.getLocalizedString("pwd_needed"))
        }else if (pwdText?.isContainsWhitespace)! {
            return (false, GlobalStatic.getLocalizedString("pwd_space"))
        }else if (pwdText?.count)! < Constants.minimumLengthPwd || (pwdText?.count)! > Constants.maximumLengthPwd {
            return (false, "\(GlobalStatic.getLocalizedString("pwd_min"))  \(Constants.minimumLengthPwd) \(GlobalStatic.getLocalizedString("pwd_max")) \(Constants.maximumLengthPwd) \(GlobalStatic.getLocalizedString("characters"))")
        }else if !(confirmPwd?.elementsEqual(pwdText!))! {
            return (false, GlobalStatic.getLocalizedString("pwd_not_matched"))
        }else if isAccepted == false {
            return (false, GlobalStatic.getLocalizedString("accept_condition"))
        }
        
        return (true, "")
    }
    
    
    @IBAction func showTerms(_ sender: Any) {
        show(viewcontrollerInstance: TermsConditionViewController.loadVC())
    }
    
}
// MARK: - Networking
extension SignUpViewController {
    
    func doRegister(params : [String : String]) {
      
    }
}

