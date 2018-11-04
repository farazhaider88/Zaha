//
//  BaseViewController.swift
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupAppDefaultNavigationBar()
        self.hideKeyboardWhenTappedAround()
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
    
    //Mark : Customizing navigation bar, adding bar buttons and custom title view
    func setupAppDefaultNavigationBar()  {
        
        //Setting navigation bar background color, its font and title color
        let barBgColor = UIColor.init(hexString: "#707070")
        let titleFont = UIFont.init(name: "FuturaStd-Medium", size: DesignUtility.getFontSize(fSize: 18))
        
        self.navigationController?.navigationBar.setCustomNavigationBarWith(navigationBarTintColor: barBgColor, navigationBarTitleFont: titleFont!, navigationBarForegroundColor: UIColor.white)
        
//        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        
//        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
//        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        self.navigationController?.navigationBar.layer.shadowRadius = 3.0
//        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
//        self.navigationController?.navigationBar.layer.masksToBounds = false
        
        //If navigation controller have more than 1 view controller then add backbutton
        if self.navigationController != nil{
            
            self.setupSideButton()
        }
    }
    
    func setupSideButton(){
        
        if (self.navigationController?.viewControllers.count)! > 1{
            
            
            //Adding bar button items with given image and its position inside navigation bar and its selector
            
            //   (UIImage(named: "backBtn")?.maskWithColor(color: UIColor.white)?.withRenderingMode(.alwaysOriginal))!
            let img = UIImage.init(named: "home_backArrow")?.flipIfNeeded()
          
            
            self.addBarButtonItemWithImage(img ?? UIImage(), CustomNavBarEnum.CustomBarButtonItemPosition.BarButtonItemPositionLeft, self, #selector(self.goBack))
        }
        
    }
    
    //Pop view controller
    @objc func goBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    //Adding bar button items with given image and its position inside navigation bar and its selector
    func addBarButtonItemWithImage<T: CustomNavBarProtocol>(_ image:UIImage,_ postion: T, _ target:UIViewController, _ selector:Selector) {
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(image, for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: DesignUtility.getValueFromRatio(44), height: DesignUtility.getValueFromRatio(44))
        btn1.addTarget(self, action: selector, for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        
        if let postion = postion as? CustomNavBarEnum.CustomBarButtonItemPosition {
            
            switch postion {
            case .BarButtonItemPositionLeft:
                
                if self.navigationItem.leftBarButtonItem != nil{
                    
                    if (self.navigationItem.leftBarButtonItems?.count)! > 0{
                        
                        self.navigationItem.leftBarButtonItems?.append(item1)
                    }
                }
                else{
                    
                    self.navigationItem.leftBarButtonItem = item1
                }
                
            case .BarButtonItemPositionRight:
                
                if self.navigationItem.rightBarButtonItem != nil{
                    
                    if (self.navigationItem.rightBarButtonItems?.count)! > 0{
                        
                        self.navigationItem.rightBarButtonItems?.append(item1)
                    }
                }
                else{
                    
                    self.navigationItem.rightBarButtonItem = item1
                }
            }
        }
    }
    
    // Adding custom title view for navigation bar
    func addCustomTitleView(_ tileView:UIView) {
        
        // tileView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //tileView.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        tileView.frame = titleView.bounds
        self.navigationItem.titleView = tileView
    }
    
    
    @objc func slideCell(cell : UITableViewCell) {
        
        Animations.slideView(view: cell)
    }
}

//Mark : - Custom delegate for accessing diferrent properties of navigation bar
protocol CustomNavBarProtocol { }

enum CustomNavBarEnum: CustomNavBarProtocol {
    
    enum CustomBarButtonItemPosition: Int, CustomNavBarProtocol {
        
        case  BarButtonItemPositionRight = 1
        case  BarButtonItemPositionLeft = 2
    }
}

//Customzing default navigation bar appearence
extension UINavigationBar
{
    
    func setCustomNavigationBarWith(navigationBarTintColor color:UIColor, navigationBarTitleFont titleFont:UIFont, navigationBarForegroundColor foregroundColor:UIColor)
    {
        
        //165    77    52
        barTintColor = color
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: foregroundColor, NSAttributedString.Key.font: titleFont]
        titleTextAttributes = (titleDict as! [NSAttributedString.Key : Any])
    }
}

//Mark : - Delegate for pressing navigation controller toolbar buttons
protocol DelegateToolbarButtons {
    
    func chatButtonPressed()
    func forwardButtonPressed()
}

