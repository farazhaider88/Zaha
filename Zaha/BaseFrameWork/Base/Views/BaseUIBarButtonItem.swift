//
//  BaseUIBarButtonItem.swift


import UIKit

open class BaseUIBarButtonItem: UIBarButtonItem, FontDesignable {
    
    // MARK: - FontDesignable
    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib();
        
        configureFont();
    }
}

