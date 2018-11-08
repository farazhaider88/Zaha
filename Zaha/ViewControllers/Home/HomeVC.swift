//
//  HomeVC.swift
//  Zaha
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

enum ExperienceType: Int {
    case ExperienceTypeUpcoming = 0
    case ExperienceTypeStories = 1
}

class HomeVC: BaseViewController, StoryBoardHandler {
    
    var experienceType = ExperienceType.ExperienceTypeUpcoming
    
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.home.rawValue , nil)
    
    @IBOutlet weak var homeTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        homeTblView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        // Do any additional setup after loading the view.
        
    }
    func setNavBar()
    {
        self.title = "HOME"
        self.navigationController?.isNavigationBarHidden = false
        
        let menuImg = UIImage.init(named: "home_menuIcon")?.flipIfNeeded()
        
        self.addBarButtonItemWithImage(menuImg!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }

    @objc func actionMenuButton()
    {
        sideMenuController?.showLeftViewAnimated()
    }
    
    //home_menuIcon
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "UpcommingExperienceSegue"
//        {
//
//        }else{
//
//        }
//    }
 
}

extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        if (indexPath.row % 2 == 0) {
            cell.experienceVideoIconImageView.isHidden = true
        }else{
            cell.experienceVideoIconImageView.isHidden = false
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if (indexPath.row % 2 == 0) {
            experienceType = ExperienceType.ExperienceTypeUpcoming
          }else{
            experienceType = ExperienceType.ExperienceTypeStories
        }
        
        if experienceType == ExperienceType.ExperienceTypeUpcoming{
            let storyboard = UIStoryboard(name: "UpcommingExperienceModule", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UpcommingExperienceDetailViewController") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)

        }else{
            
//ForShowingPopup
            let storyboard = UIStoryboard(name: "PopupsModule", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PopupViewController") as UIViewController
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
        
       
    }
}
