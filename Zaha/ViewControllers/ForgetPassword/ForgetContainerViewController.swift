//
//

import UIKit

class ForgetContainerViewController: UIViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue, nil)
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblForgetPwd: BaseUILabel!
    @IBOutlet weak var lblNoProb: BaseUILabel!
    @IBOutlet weak var btnResetPwd: CustomButton!
    
    
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
        lblForgetPwd.text = GlobalStatic.getLocalizedString("forget_ur_pwd")
        lblNoProb.text = GlobalStatic.getLocalizedString("lbl_no_problem")
        btnGoBack.setImage(UIImage.init(named: "backBtn")?.flipIfNeeded(), for: .normal)
        btnResetPwd.setTitle(GlobalStatic.getLocalizedString("reset_pwd"), for: .normal)
        
    }
    
    func setupForAnimation() {
        imgLogo.isHidden = true
        lblForgetPwd.isHidden = true
        lblNoProb.isHidden = true
        btnResetPwd.isHidden = true
    }
    
    @objc func animate(){
        
        // var t = 0.1
        //  var diff = 0.5
        
        perform(#selector(flipImg), with: nil, afterDelay: 0.0)
        perform(#selector(flipLabelPwd), with: nil, afterDelay: 0.1)
        perform(#selector(flipLblNoProb), with: nil, afterDelay: 0.2)
        perform(#selector(flipReset), with: nil, afterDelay: 0.3)
    
        // perform(#selector(imgLogo.flipFromRight), with: nil, afterDelay: 0.17)
    }
    
    @objc func flipImg() {
        imgLogo.flipFromRight()
      }
    
    @objc func flipLabelPwd() {
        lblForgetPwd.flipFromRight()
    }
    
    @objc func flipLblNoProb() {
        lblNoProb.flipFromRight()
    }
    @objc func flipReset(){
        btnResetPwd.flipFromRight()
    }
    
   

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: Any) {
     show(viewcontrollerInstance: EnterEmailViewController.loadVC())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
