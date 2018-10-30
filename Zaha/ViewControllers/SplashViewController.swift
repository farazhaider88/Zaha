//
//  SplashViewController.swift
//

import UIKit

class SplashViewController: UIViewController , StoryBoardHandler {
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.main.rawValue, nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        
        GlobalStatic.delay(delay: 3) { [weak self] in

            
            if let strongSelf = self{
               // router.goToViewController(from: strongSelf, withTitle: "My Form")
                router.goToLoginScreen(from: strongSelf)
            }

        }
        
     
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
