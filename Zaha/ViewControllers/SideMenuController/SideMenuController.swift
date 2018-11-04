

import UIKit
import LGSideMenuController

class SideMenuController: LGSideMenuController, StoryBoardHandler
{
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.sideMenu.rawValue , nil)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.leftViewWidth = self.view.frame.size.width * DesignUtility.getValueFromRatio(0.7)
        self.leftViewStatusBarStyle = .lightContent
        self.isLeftViewSwipeGestureEnabled = false
//        self.rightViewWidth = self.view.frame.size.width * DesignUtility.getValueFromRatio(0.7)
//        self.rightViewStatusBarStyle = .lightContent
//        self.isRightViewSwipeGestureEnabled = false
//        self.isRightViewStatusBarHidden = false
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
} // end class SideMenuController


