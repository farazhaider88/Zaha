//
//  Alert.swift


import UIKit

public class Alert {
    
    private static var parentWindow:UIViewController?;
    
    private init(){
        
    }
    
    public static func showMsg(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay" ) -> Void{
        
        self.parentWindow = nil;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showMsg(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay", parentViewController:UIViewController? ) -> Void{
        
        self.parentWindow = parentViewController;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    
    
    public static func showWithCompletion(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay" , completionAction: @escaping () -> Void) -> Void{
        
        self.parentWindow = nil;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithCompletion(title : String = "Notification", msg : String , btnActionTitle : String? = "Okay" , completionAction: @escaping () -> Void, parentViewController:UIViewController? ) -> Void{
        
        self.parentWindow = parentViewController;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: btnActionTitle, style: .default) { (action) in
            
            completionAction()
        }
        alertController .addAction(alertAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithTwoActions(title : String , msg : String , okBtnTitle : String , okBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void) -> Void{
        
        self.parentWindow = nil;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (action) in
            
            okBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithTwoActions(title : String , msg : String , okBtnTitle : String , okBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void, parentViewController:UIViewController?) -> Void{
        
        self.parentWindow = parentViewController;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: okBtnTitle, style: .default, handler: { (action) in
            
            okBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(doneAction)
        
        alertController .addAction(cancelAction)
        
        Alert.showOnWindow(alertController)
    }
    
    public static func showWithThreeActions( title : String , msg : String , FirstBtnTitle : String , FirstBtnAction: @escaping () -> Void , SecondBtnTitle : String , SecondBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void) -> Void{
        
        self.parentWindow = nil;
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (action) in
            
            FirstBtnAction()
        })
        
        
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (action) in
            
            SecondBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
        
        
        
        Alert.showOnWindow(alertController)
        
    }
    
    public static func showWithThreeActions( title : String , msg : String , FirstBtnTitle : String , FirstBtnAction: @escaping () -> Void , SecondBtnTitle : String , SecondBtnAction: @escaping () -> Void , cancelBtnTitle : String , cancelBtnAction: @escaping () -> Void, parentViewController:UIViewController?) -> Void{
        
        self.parentWindow = parentViewController;
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let firstBtnAction = UIAlertAction(title: FirstBtnTitle, style: .default, handler: { (action) in
            
            FirstBtnAction()
        })
        
        
        let secondBtnAction = UIAlertAction(title: SecondBtnTitle, style: .default, handler: { (action) in
            
            SecondBtnAction()
        })
        
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default, handler: { (action) in
            
            cancelBtnAction()
        })
        
        alertController .addAction(firstBtnAction)
        alertController .addAction(secondBtnAction)
        alertController .addAction(cancelAction)
        
        
        
        Alert.showOnWindow(alertController)
        
    }
    
    private static func showOnWindow(_ alert : UIAlertController) {
        
        if parentWindow != nil {
            parentWindow?.present(alert, animated: true, completion: nil)
        }
        else {
            
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alert, animated: true, completion: nil)
                // topController should now be your topmost view controller
            }
        }
        
        
    }
}


