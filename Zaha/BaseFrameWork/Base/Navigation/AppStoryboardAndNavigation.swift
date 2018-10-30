//
//  AppStoryboardAndNavigation.swift


import Foundation
import UIKit

public extension StoryBoardHandler where Self: UIViewController {
    // Code
    
    public static func loadVC() -> Self{
        
        if DeviceUtility.isIpad() == false{
            
            return viewController(viewControllerClass: self, storyBoardName: self.myStoryBoard.forIphone)
        }
        else if DeviceUtility.isIpad() == true{
            
            if self.myStoryBoard.forIpad == nil{
                
                return viewController(viewControllerClass: self, storyBoardName: self.myStoryBoard.forIphone)
            }
        }
        
        return viewController(viewControllerClass: self, storyBoardName: self.myStoryBoard.forIpad)
    }
    
    // Instanitating an specific storyboard
    static func instanceStoryBoard(storyboardName : String) -> UIStoryboard {
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }
    
    // Instanitating an specific view controller from storyboard
    public static func viewController<T : UIViewController>(viewControllerClass : T.Type, storyBoardName : String?,  function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instanceStoryBoard(storyboardName:storyBoardName!).instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(String(describing: storyBoardName)) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    // MARK: - Show(push) given view controller with given parametters
    public func show<T: UIViewController>(viewcontrollerInstance:UIViewController , configure: ((T) -> Void)? = nil) {
        
        configure?(viewcontrollerInstance as! T)
        show(viewcontrollerInstance, sender: self)
    }
    
    // MARK: - Instanitate the view controller object and Present it with given parametters if required
    
    public func presentViewController<T: UIViewController>(viewControllerInstance:UIViewController, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle, completion: ((T) -> Void)? = nil) {
        
        //        let viewControllerInstance = viewcontrollerInstance.instantiate(fromAppStoryboard: viewcontrollerInstance.myStoryBoard)
        
        //        if let modalPresentationStyle = modalPresentationStyle {
        viewControllerInstance.modalPresentationStyle = modalPresentationStyle
        //        }
        
        //        configure?(viewControllerInstance as! T)
        present(viewControllerInstance, animated: animated) {
            
            completion?(viewControllerInstance as! T)
        }
    }
    
    
    // MARK: - Push given view controller with given parametters and custom navigation controller
    public func navigateWithCustomNavigation<T: UIViewController>(viewControllerInstance:UIViewController, navController:UINavigationController? , configure: ((T) -> Void)? = nil) {
        
        configure?(viewControllerInstance as! T)
        
        if  navController != nil{
            
            navController?.pushViewController(viewControllerInstance, animated: true)
        }
        else{
            
            print("App delegate navigation controller has not been initialized")
        }
    }
    
    // MARK: - Pop to specific view controller already in the stack
    public func popViewToViewController<T: UIViewController>(navigationController:UINavigationController ,animation : Bool, viewControllerClass:T.Type) {
        
        //        if let _ = self as? StoryBoardHandler{
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            
            return
        }
        
        //var controlerFound = false
        
        _ = controllers.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                //controlerFound = true
                _ = navCon.popToViewController((controllers[i]), animated: true)
                return;
            }
        }
    }
    
    // MARK: - Push or Pop to specific view controller
    public func pushOrPopViewController<T: UIViewController>(navigationController:UINavigationController ,animation : Bool, viewControllerClass:T.Type, viewControllerStoryboad:(forIphone : String, forIpad : String?), configurePushedVC: ((T) -> Void)? = nil) {
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            
            return
        }
        
        var controlerFound = false
        
        _ = controllers.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                controlerFound = true
                _ = navCon.popToViewController((controllers[i]), animated: true)
                return;
            }
        }
        
        if controlerFound == false{
            
            var storyboardName = ""
            
            if DeviceUtility.isIpad() == false{
                
                storyboardName = viewControllerStoryboad.forIphone
            }
            else if DeviceUtility.isIpad() == true{
                
                if viewControllerStoryboad.forIpad == nil{
                    
                    storyboardName = viewControllerStoryboad.forIphone
                }
                else{
                    
                    storyboardName = viewControllerStoryboad.forIpad!
                }
            }
            
            guard let newVC = Self.instanceStoryBoard(storyboardName:storyboardName).instantiateViewController(withIdentifier: storyboardID) as? T else {
                
                fatalError("ViewController with identifier \(storyboardID), not found in \(viewControllerStoryboad.forIphone) Storyboard.")
            }
            
            configurePushedVC?(newVC)
            navCon.pushViewController(newVC, animated: true)
        }
    }
    
    
    // MARK: - Push or Pop to specific view controller
    public func getViewController<T: UIViewController>(navigationController:UINavigationController, viewControllerClass:T.Type, viewControllerStoryboad:(forIphone : String, forIpad : String?)) -> T? {
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            return nil
            
        }
        
        var controlerFound = false
        
       
            
            for (index,object) in controllers.enumerated() {
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", index)
                controlerFound = true
                return controllers[index] as? T
            }
        }
        
        if controlerFound == false{
            
            var storyboardName = ""
            
            if DeviceUtility.isIpad() == false{
                
                storyboardName = viewControllerStoryboad.forIphone
            }
            else if DeviceUtility.isIpad() == true{
                
                if viewControllerStoryboad.forIpad == nil{
                    
                    storyboardName = viewControllerStoryboad.forIphone
                }
                else{
                    
                    storyboardName = viewControllerStoryboad.forIpad!
                }
            }
            
            guard let newVC = Self.instanceStoryBoard(storyboardName:storyboardName).instantiateViewController(withIdentifier: storyboardID) as? T else {
                
                fatalError("ViewController with identifier \(storyboardID), not found in \(viewControllerStoryboad.forIphone) Storyboard.")
            }
            
          
            return newVC as T
        }
    }
}

public extension UIViewController {
    
    // MARK: - Storyboard id to use in instantiating of view controller
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        
        return "\(self)"
    }
}

// MARK: - Protocol for setting storyboard name
public protocol StoryBoardHandler {
    
    static var myStoryBoard : (forIphone : String, forIpad : String? ) {get}
}


public protocol Routable {
    
}

public extension Routable where Self: UIViewController {
    
    
    // Instanitating an specific storyboard
    static func instanceStoryBoard(storyboardName : String) -> UIStoryboard {
        
        return UIStoryboard(name: storyboardName, bundle: Bundle.main)
    }

    // MARK: - Show(push) given view controller with given parametters
    public func show<T: UIViewController>(viewcontrollerInstance:UIViewController , configure: ((T) -> Void)? = nil) {
        
        configure?(viewcontrollerInstance as! T)
        show(viewcontrollerInstance, sender: self)
    }
    
    // MARK: - Instanitate the view controller object and Present it with given parametters if required
    
    public func presentViewController<T: UIViewController>(viewControllerInstance:UIViewController, animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle, completion: ((T) -> Void)? = nil) {
        
        //        let viewControllerInstance = viewcontrollerInstance.instantiate(fromAppStoryboard: viewcontrollerInstance.myStoryBoard)
        
        //        if let modalPresentationStyle = modalPresentationStyle {
        viewControllerInstance.modalPresentationStyle = modalPresentationStyle
        //        }
        
        //        configure?(viewControllerInstance as! T)
        present(viewControllerInstance, animated: animated) {
            
            completion?(viewControllerInstance as! T)
        }
    }
    
    
    // MARK: - Push given view controller with given parametters and custom navigation controller
    public func navigateWithCustomNavigation<T: UIViewController>(viewControllerInstance:UIViewController, navController:UINavigationController? , configure: ((T) -> Void)? = nil) {
        
        configure?(viewControllerInstance as! T)
        
        if  navController != nil{
            
            navController?.pushViewController(viewControllerInstance, animated: true)
        }
        else{
            
            print("App delegate navigation controller has not been initialized")
        }
    }
    
    // MARK: - Pop to specific view controller already in the stack
    public func popViewToViewController<T: UIViewController>(navigationController:UINavigationController ,animation : Bool, viewControllerClass:T.Type) {
        
        //        if let _ = self as? StoryBoardHandler{
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            
            return
        }
        
        //var controlerFound = false
        
        _ = controllers.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                //controlerFound = true
                _ = navCon.popToViewController((controllers[i]), animated: true)
                return;
            }
        }
    }
    
    // MARK: - Push or Pop to specific view controller
    public func pushOrPopViewController<T: UIViewController>(navigationController:UINavigationController ,animation : Bool, viewControllerClass:T.Type, viewControllerStoryboad:(forIphone : String, forIpad : String?), configurePushedVC: ((T) -> Void)? = nil) {
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            
            return
        }
        
        var controlerFound = false
        
        _ = controllers.enumerated().flatMap { i, object in
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", i)
                
                controlerFound = true
                _ = navCon.popToViewController((controllers[i]), animated: true)
                return;
            }
        }
        
        if controlerFound == false{
            
            var storyboardName = ""
            
            if DeviceUtility.isIpad() == false{
                
                storyboardName = viewControllerStoryboad.forIphone
            }
            else if DeviceUtility.isIpad() == true{
                
                if viewControllerStoryboad.forIpad == nil{
                    
                    storyboardName = viewControllerStoryboad.forIphone
                }
                else{
                    
                    storyboardName = viewControllerStoryboad.forIpad!
                }
            }
            
            guard let newVC = Self.instanceStoryBoard(storyboardName:storyboardName).instantiateViewController(withIdentifier: storyboardID) as? T else {
                
                fatalError("ViewController with identifier \(storyboardID), not found in \(viewControllerStoryboad.forIphone) Storyboard.")
            }
            
            configurePushedVC?(newVC)
            navCon.pushViewController(newVC, animated: true)
        }
    }
    
    
    // MARK: - Push or Pop to specific view controller
    public func getViewController<T: UIViewController>(navigationController:UINavigationController, viewControllerClass:T.Type, viewControllerStoryboad:(forIphone : String, forIpad : String?)) -> T? {
        
        let navCon = navigationController
        
        let controllers = navCon.viewControllers
        let countControllers = controllers.count
        
        let storyboardID = viewControllerClass.storyboardID
        
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + storyboardID
        
        if countControllers == 0 {
            return nil
            
        }
        
        var controlerFound = false
        
        
        
        for (index,object) in controllers.enumerated() {
            
            if (object.isKind(of: NSClassFromString(className)!))
            {
                NSLog("controller found at index %d", index)
                controlerFound = true
                return controllers[index] as? T
            }
        }
        
        if controlerFound == false{
            
            var storyboardName = ""
            
            if DeviceUtility.isIpad() == false{
                
                storyboardName = viewControllerStoryboad.forIphone
            }
            else if DeviceUtility.isIpad() == true{
                
                if viewControllerStoryboad.forIpad == nil{
                    
                    storyboardName = viewControllerStoryboad.forIphone
                }
                else{
                    
                    storyboardName = viewControllerStoryboad.forIpad!
                }
            }
            
            guard let newVC = Self.instanceStoryBoard(storyboardName:storyboardName).instantiateViewController(withIdentifier: storyboardID) as? T else {
                
                fatalError("ViewController with identifier \(storyboardID), not found in \(viewControllerStoryboad.forIphone) Storyboard.")
            }
            
            
            return newVC as T
        }
    }
}



