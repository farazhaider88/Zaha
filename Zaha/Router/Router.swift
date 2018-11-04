
import UIKit

class Router  {
 
    typealias viewController  =  StoryBoardHandler & UIViewController
    
    func goToViewController(from vc : viewController , withTitle title : String) {
      
      vc.show(viewcontrollerInstance: ViewController.loadVC()) { (vc : ViewController) in
            vc.titleHeader = title
        }
        
        
    }
    
    
    
    func goToHomeAsRoot(from vc : viewController)
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle: nil)
        
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
        UIApplication.shared.keyWindow?.rootViewController = viewController
//        vc.navigationController?.setViewControllers([SideMenuController.loadVC()], animated: true)
    }
    
    func goToLoginScreen(from vc : viewController) {
        
         vc.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
    }
    
    
    func goToEnterCodeVC(from vc : viewController, codeType : CodeType) {
      vc.show(viewcontrollerInstance: EnterCodeViewController.loadVC()) { (vc : EnterCodeViewController) in
            vc.type = codeType
        }
    }
    
    func goToChangePwdVC(from vc : viewController)  {
        
        vc.show(viewcontrollerInstance: ChangePasswordViewController.loadVC())
    }
    
    func goToSettingsVC(from vc : viewController) {
        
          vc.show(viewcontrollerInstance: SettingViewController.loadVC())
   
    }
    
    func goToResetPwd(from vc : viewController) {
        vc.show(viewcontrollerInstance: ResetPasswordViewController.loadVC())
    }
    
    func goToTerms(from vc : viewController) {
        vc.show(viewcontrollerInstance: TermsConditionViewController.loadVC())
    }
    
    
}
