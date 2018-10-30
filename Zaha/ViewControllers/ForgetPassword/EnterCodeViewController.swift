//
//

import UIKit

class EnterCodeViewController: UIViewController, StoryBoardHandler, CodeInputViewDelegate {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    
    @IBOutlet weak var viewContent: UIView!
    var codeVerify = ""
    var isTyped = false
    var codeInputView : CodeInputView!
  
    
    var type : CodeType = .forgetPwd
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblEnterCode: BaseUILabel!
    @IBOutlet weak var lblEnterCodeSub: BaseUILabel!
    @IBOutlet weak var btnSubmit: CustomButton!
    @IBOutlet weak var lblDidntGetCode: BaseUILabel!
    
    
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var lblHeader: BaseUILabel!
    
    
    @IBOutlet weak var btnResendCode: BaseUIButton!
    
    var seconds = 60
    var minutes = 1
    var timer = Timer()
    var isTimerRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationController?.isNavigationBarHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let viewWidth : CGFloat = 215
        let yPos = DeviceUtility.getDeviceType() == .iPhoneX ? DesignUtility.getValueFromRatio(430) : DesignUtility.getValueFromRatio(400)
   
        let frame =  CGRect(x: (self.view.frame.size.width - viewWidth) / 2, y: yPos, width: viewWidth, height: 60)
        
         codeInputView = CodeInputView(frame: frame)
        codeInputView.delegate = self
//        for a in codeVerify{
//        codeInputView.insertText(String(a))
//       }
        codeVerify = ""
        codeInputView.countCode = 0 //self.codeVerify.count
        viewContent.addSubview(codeInputView)
     
        self.hideKeyboardWhenTappedAround()
        setTextAsPerLanguage()
        setupForAnimation()
        perform(#selector(animate), with: nil, afterDelay: 0.2)
       //--ww  lblDidntGetCode.text = "Didn’t get a code yet? Wait for 2:00 seconds"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
          self.timer.invalidate()
    }
    
    
    func setTextAsPerLanguage() {
        if type == .signup {
        lblHeader.text = GlobalStatic.getLocalizedString("enter_code")
        }else{
           lblHeader.text = GlobalStatic.getLocalizedString("forget_pwd")
        }
        btnGoBack.setImage(UIImage.init(named: "backBtn")?.flipIfNeeded(), for: .normal)
        lblEnterCode.text = GlobalStatic.getLocalizedString("enter_code")
        lblEnterCodeSub.text = GlobalStatic.getLocalizedString("enter_4_digit")
        lblDidntGetCode.text = GlobalStatic.getLocalizedString("wait_for_full")
        btnSubmit.setTitle(GlobalStatic.getLocalizedString("submit"), for: .normal)
    }
    
    func setupForAnimation() {
        imgLogo.isHidden = true
        lblEnterCode.isHidden = true
        lblEnterCodeSub.isHidden = true
        codeInputView.isHidden = true
        lblDidntGetCode.isHidden = true
        btnSubmit.isHidden = true
        btnResendCode.isHidden = true
    }
    
    @objc func animate(){
        
        // var t = 0.1
        //  var diff = 0.5
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipLblEnterCode), with: nil, afterDelay: 0.1)
        perform(#selector(flipLblEnterCodeSub), with: nil, afterDelay: 0.2)
        perform(#selector(flipCodeInputView), with: nil, afterDelay: 0.3)
        perform(#selector(flipLblDidntCode), with: nil, afterDelay: 0.4)
        perform(#selector(flipBtn), with: nil, afterDelay: 0.5)
        
      
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
    }
    
    @objc func flipLblEnterCode() {
        lblEnterCode.flipFromRight()
    }
    
    @objc func flipLblEnterCodeSub() {
       lblEnterCodeSub.flipFromRight()
    }
    @objc func flipCodeInputView(){
        codeInputView.flipFromRight()
    }
    
    
    @objc func flipLblDidntCode() {
        lblDidntGetCode.flipFromRight()
    }
    @objc func flipBtn(){
        btnSubmit.flipFromRight()
        
        if isTimerRunning == false {
           seconds = 60
           minutes = 1
            runTimer()
            
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
          
             //self.view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                if self.viewContent.frame.origin.y == 0{
                    
//                    UIView.animate(withDuration: 0.2, animations: {
//                         self.view.frame.origin.y -= (keyboardSize.height / 2)
//                    })
                    
                    UIView.animate(withDuration: 0.2, animations: {
                         self.viewContent.frame.origin.y -= (keyboardSize.height / 2)
                    }, completion: { (v) in
                        self.codeVerify = ""
                        self.codeInputView.countCode = 0
                      //  self.view.isUserInteractionEnabled = true
                    })
                  
                }
            })
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //let keyboardSize = 
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
            if self.viewContent.frame.origin.y != 0{
                
                self.viewContent.frame.origin.y  = 0
}
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        print("CodeViewController deallocated")
    }
    
    
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
   
        
    }

    
    @objc func updateTimer() {
        
        if seconds < 1 {
            timer.invalidate()
            //Send alert to indicate time's up.
           
            lblDidntGetCode.isHidden = true
            btnResendCode.isHidden = false
            
        } else {
            seconds -= 1
            if seconds == 0  && minutes == 1{
              minutes -= 1
                let time =  String(format: "%02d:%02d", minutes, seconds)
               // "\(minutes):\(seconds)"
                let sec = seconds < 2 ? GlobalStatic.getLocalizedString("second") :  GlobalStatic.getLocalizedString("seconds")
                
                  lblDidntGetCode.text = "\(GlobalStatic.getLocalizedString("wait_for_some") )\(time) \( sec)"
                seconds = 60
            }else{
                let time =  String(format: "%02d:%02d", minutes, seconds)
                // "\(minutes):\(seconds)"
                let sec = seconds < 2 ? GlobalStatic.getLocalizedString("second") :  GlobalStatic.getLocalizedString("seconds")
                lblDidntGetCode.text = "\(GlobalStatic.getLocalizedString("wait_for_some") ) \(time)  \( sec)"
            }
         
         
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func codeInputView(_ codeInputView: CodeInputView, didFinishWithCode code: String) {

        //--ww timer.invalidate()
        isTyped = true
        codeVerify = code
    }

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        print(codeInputView.countCode)

        
        if codeInputView.countCode == 4{
          checkCode(code: codeVerify)
        }else{
            Alert.showWithCompletion(msg: "Kindly write 4 digit code", completionAction: {
             
            })
        }
        
    }
    
    
    
    @IBAction func sendMeCodeAgain(_ sender: Any) {
        
         
    }
    
}

// MARK: - Networking
extension EnterCodeViewController{
    
    func checkCode(code : String) {
        
     verifyCode()
    }
    
    
 func verifyCode() {
        if codeVerify == "1234" {
            Alert.showWithCompletion(msg: "Code Verified!", completionAction: {
                
                router.goToChangePwdVC(from: self)
            })
        }else{
            Alert.showWithCompletion(msg: "Wrong Code", completionAction: {
                self.codeInputView.clear()
                self.codeVerify = ""
                self.codeInputView.countCode = 0
               //--ww self.codeInputView.becomeFirstResponder()
                self.isTyped = false
            })
        }
    }
    
}


