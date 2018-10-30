//
//  BaseUINavigationController.swift


import UIKit

open class BaseUINavigationController: UINavigationController, FontDesignable, FillDesignable {
    public var opacity: CGFloat = 1;
    
    
    // MARK: - FontDesignable
    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorTheme:String? = DefaultConfig.shared.defaultFontColor  {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    // MARK:- Separator
    @IBInspectable open var hasSeparator:Bool = true {
        didSet {
            if (!hasSeparator) {
                self.navigationBar.setBackgroundImage(UIImage(), for: .default);
                self.navigationBar.shadowImage = UIImage();
            } else {
                self.navigationBar.setBackgroundImage(nil, for: .default);
                self.navigationBar.shadowImage = nil;
            }
        }
    }
    
    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            configureFillColor();
        }
    }
    
    
    // MARK:- Overrides
    override public init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController);
    }
    
    override public init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

