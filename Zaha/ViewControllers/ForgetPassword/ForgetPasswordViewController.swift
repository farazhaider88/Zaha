//
//  ForgetPasswordViewController.swift
//

import UIKit

class ForgetPasswordViewController: BaseViewController, StoryBoardHandler {

    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.registeration.rawValue , nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()

        // Do any additional setup after loading the view.
    }
    func setNavBar()
    {
        self.title = "FORGOT PASSWORD"
        self.navigationController?.isNavigationBarHidden = false
        
        //        let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
        //self.addBarButtonItemWithImage(img!,CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(actionMenuButton))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
