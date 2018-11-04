//
//  LeftMenuController.swift
//  VIE
//
//  Created by aurangzaibkhan on 6/26/18.
//  Copyright © 2018 aurangzaibkhan. All rights reserved.
//

import UIKit
import LGSideMenuController
//import FCAlertView
import SwiftMessages
import RealmSwift
//import SKActivityIndicatorView
import Alamofire

enum Menu: String
{
    case home = "Home"
    case stories = "Stories"
    case upcomingExp = "Upcoming Experiences"
    case nearMe = "Near Me"
    case pastExp = "Past Experiences"
    case myExp = "My Experiences"
    case inbox = "Inbox"
    case setting = "Settings"
    case about = "About"
}

extension Menu
{
    
    func getVc() -> BaseViewController
    {
        switch self
        {
        case .home:
            
            return HomeViewController.loadVC()
            
//        case .featuredAds:
//
////            let vc = AdsListingController.loadVC()
////            vc.navTitle = "Featured Ads"
////            return vc
//
//            let  parameters = [
//                "IsFeatured" : 1,
//                ] as [String : AnyObject]
//
//            let vc = HomeVC.loadVC()
//            vc.navTitle = "Featured Ads"
//            vc.parameters = parameters
//            return vc
//
//        case .favorites:
//
//            let  parameters = [
//                "isfavourite" : 1,
//                ] as [String : AnyObject]
//
//            let vc = HomeVC.loadVC()
//            vc.navTitle = "Favorites"
//            vc.parameters = parameters
//            return vc
//
//        case .myAds:
//
////            let vc = MyAdsListingController.loadVC()
////            //vc.navTitle = "My Ads"
////            return vc
//
//            let  parameters = [
//                "isMyAd" : 1,
//                ] as [String : AnyObject]
//
//            let vc = AdsListingController.loadVC()
//            vc.navTitle = "My Ads"
//            vc.parameters = parameters
//            return vc
//
//        case .exhibitions:
//            return ExhibitionController.loadVC()
//
//        case .notifications:
//           return NotificationController.loadVC()
//
//
//        case .settings:
//
//            return SettingViewController.loadVC()
//
//        case .contactUs:
//            return ContactController.loadVC()
            
        default :
            return BaseViewController()
        }
    }
}

class LeftMenuController: BaseViewController
{
    @IBOutlet weak var tblSideMenu: UITableView!
    
    private let kTableHeaderHeight: CGFloat = DesignUtility.getValueFromRatio(80)
    //let manager = LogoutManager()
    let realm = try! Realm()

    var menuArray = [
        ["icon":"sidebar_homeIcon", "type":Menu.home.rawValue],
        ["icon":"sidebar_storiesIcon", "type":Menu.stories.rawValue],
        ["icon":"sidebar_upcomingExpIcon", "type":Menu.upcomingExp.rawValue],
        ["icon":"sidebar_nearbyIcon", "type":Menu.nearMe.rawValue],
        ["icon":"sidebar_pastExpIcon", "type":Menu.pastExp.rawValue],
        ["icon":"sidebar_myExpIcon", "type":Menu.myExp.rawValue],
        ["icon":"sidebar_inboxIcon", "type":Menu.inbox.rawValue],
        ["icon":"sidebar_settingsIcon", "type":Menu.setting.rawValue],
        ["icon":"sidebar_aboutIcon", "type":Menu.about.rawValue]
    ]
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // setHeader()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
    }
    
    func setHeader()
    {
        tblSideMenu.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0 )
        tblSideMenu.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
    }
    
    
    func setRootViewController(_ vc: UINavigationController)
    {
        sideMenuController?.rootViewController = vc
        //Singleton.sharedInstance.sideMenuVC = vc
        sideMenuController?.hideLeftViewAnimated()
    }
    
    @IBAction func actionCross(_ sender: UIButton) {
        sideMenuController?.hideLeftViewAnimated()
    }
    
    func changeControllers(_ menu: Menu)
    {
//        if menu == .logOut
//        {
//            //customAlert(title: NSLocalizedString("Logout", comment: ""), subTitle: NSLocalizedString("Are you sure you want to logout?", comment: ""), image: #imageLiteral(resourceName: "logo"))
//        }
//        else
//        {
//            setRootViewController(UINavigationController(rootViewController: menu.getVc()))
//        }
        setRootViewController(UINavigationController(rootViewController: menu.getVc()))
    }
    
    func logOutService(){
        
//        self.view.endEditing(true)
//        if !Connectivity.isConnectedToInternet {
//            self.view.makeToast(AppString.internetUnreachable, duration: 1.5, position: .center)
//            return
//        }
//        
//        let headers: [String:String] = ["Authorization": "Bearer \(CurrentUser.token)"]
//        
//        let parameters = [
//            "deviceID" :CurrentUser.deviceToken,
//            "deviceType" : 2
//            ] as! [String:Any]
//        
//        print(headers)
//        print(parameters)
//        
//         SKActivityIndicator.show("Loading...", userInteractionStatus: false)
//        AFWrapper.requestPOSTURL("http://vie.ingicweb.com/API/api/User/LogOut", params: parameters, headers: headers, success: { (data) in
//            SKActivityIndicator.dismiss()
//            
//            try! self.realm.write{
//                self.realm.delete(CurrentUser.data!)
//            }
//            CurrentUser.data = nil
//            self.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
//            
//        }) { (Error) in
//            
//        }
        
   /*     let requestParam = self.manager.params(parameters: parameters as! [String : AnyObject])
        
        SKActivityIndicator.show("Loading...", userInteractionStatus: false)
        self.manager.api(requestParam, completion: {
            SKActivityIndicator.dismiss()
            
            if self.manager.isSuccess{
                
                try! self.realm.write{
                    self.realm.delete(CurrentUser.data!)
                }
                CurrentUser.data = nil
                //--FM  Constants.APP_DELEGATE.moveToSignIn()
                self.navigationController?.setViewControllers([LoginViewController.loadVC()], animated: true)
            }
            else{
                
            }
        }) */
        
    } // end logOutService
    
} // end class LeftMenuController

extension LeftMenuController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return SideMenuTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellType = (self.menuArray[indexPath.row] as NSDictionary)["type"] as! String
        
        if let menu = Menu(rawValue: cellType)
        {
            self.changeControllers(menu)
        }
    }
}

extension LeftMenuController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        
        cell.imgSideMenuIcon.image = UIImage(named:menuArray[indexPath.row]["icon"]!)
        cell.lblTitle.text = menuArray[indexPath.row]["type"]
        
        return cell
    }
}

extension LeftMenuController
{
//    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
//    {
//        if index == 0
//        {
//            logOutService()
//        }
//        else if index == 1
//        {
//            alertView.dismiss()
//        }
//    }
}





