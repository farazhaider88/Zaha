//
//  SettingViewController.swift
//

import UIKit
import MOLH

class SettingViewController: BaseViewController, StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.setting.rawValue, nil)
    
    @IBOutlet weak var tblSettings: UITableView!
     let settingCellReuseIdentifier = "SettingsTableViewCell"
    
    let dataArray : [CellType] = [.pushNotification, .changePwd, .language, .logout ]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpHeader()
        setUpTable()
    }
    
    func setUpHeader() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.title =  GlobalStatic.getLocalizedString("settings")
       
    }

    func setUpTable() {
        
        tblSettings.delegate = self
        tblSettings.dataSource = self
      tblSettings.register(UINib.init(nibName: settingCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: settingCellReuseIdentifier)
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit {
        
        print("SettingViewController deallocated")
    }
    

}
extension SettingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell  = tableView.dequeueReusableCell(withIdentifier: settingCellReuseIdentifier) as! SettingsTableViewCell
        cell.configCell(data: dataArray[indexPath.row])
        cell.switchAction = { [weak self] bool , int in
            print(bool , int)
          //  let st = (bool) ? 1 : 0
      self?.setPushNotificationStatus(status: bool ? 1 : 0)
            
        }
         cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  DesignUtility.getValueFromRatio(75)
    }
    
    
}

extension SettingViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let option = dataArray[indexPath.row]
        switch option {
        case .pushNotification:
         
          break
        case .changePwd:
            router.goToResetPwd(from: self)
         break
        case .language:
            
       
        
            Alert.showWithTwoActions(title : "" , msg: GlobalStatic.getLocalizedString("choose_language"), okBtnTitle: "English", okBtnAction: {
                if MOLHLanguage.currentAppleLanguage() == "ar" {
                    MOLH.setLanguageTo("en")
                    MOLH.reset()
                }
            }, cancelBtnTitle: "عربي", cancelBtnAction: {
                // MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en"
                if MOLHLanguage.currentAppleLanguage() == "en" {
                    MOLH.setLanguageTo("ar")
                    MOLH.reset()
                }
                
            }, parentViewController : self)

         break
        case .logout:
            
         print("LogOut")
         DispatchQueue.main.async {
            Alert.showWithTwoActions(title : "" ,msg: GlobalStatic.getLocalizedString("logout_confirmation"), okBtnTitle: GlobalStatic.getLocalizedString("yes"), okBtnAction: {
                
                self.logOutFromServer()
            }, cancelBtnTitle: GlobalStatic.getLocalizedString("no"), cancelBtnAction: {
                
            }, parentViewController : self)
         }
    

            
            break
        }
    }
    
    func doLogout() {
      
        //--ww  let vc = UINavigationController.init(rootViewController: LoginViewController.loadVC())
        
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let nav = UINavigationController.init(rootViewController: LoginViewController.loadVC())
        rootviewcontroller.rootViewController = nav
        //--ww self.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
    }
}



enum CellType : String {
    case pushNotification = "push_notification"
    case changePwd = "change_pwd"
    case language = "language"
    case logout = "logout"
}

// MARK: - Networking
extension SettingViewController {
    
    func setPushNotificationStatus(status : Int) {
        
     
    }
    
    
    func logOutFromServer() {
        doLogout()
        
    }
}
