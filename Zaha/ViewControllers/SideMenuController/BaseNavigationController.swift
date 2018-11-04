//
//  BaseNavigationController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, StoryBoardHandler
{
    static var myStoryBoard: (forIphone: String, forIpad: String?) = (Storyboards.main.rawValue, nil)
    
    var isInternal = false
    //var controller: controllers!
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return UIStatusBarStyle.default
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.isEnabled = false
//        self.navigationBar.barTintColor = UIColor.black

        let navigationBar = self.navigationBar
       // navigationBar.setBackgroundImage(#imageLiteral(resourceName: "BarBackground"),
                      //                   for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
//        if controller == Controllers.ChaletDetail
//        {
//            self.navigationBar.barTintColor = UIColor.clear
//        }
//        else
//        {
//            self.navigationBar.barTintColor = AppConstants.blueNavBar
//        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
    }
    
    func test()
    {
        
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close:")
        //        this.na
        //        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
        //        style:UIBarButtonItemStyleBordered
        //        target:self
        //        action:@selector(close:)];
        
    }
}
