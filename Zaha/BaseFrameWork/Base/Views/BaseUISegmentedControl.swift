//
//  BaseUISegmentedControl.swift


import UIKit

open class BaseUISegmentedControl: UISegmentedControl, FontDesignable, FillDesignable, TintDesignable {

    
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

    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            configureFillColor();
        }
    }
    
    
    @IBInspectable open var opacity: CGFloat = CGFloat.nan {
        didSet {
            configureOpacity();
        }
    }
    
    // MARK: - TintDesignable
    @IBInspectable open var tintThemeColor: String? {
        didSet {
            configureTintColor();
        }
    }

    //MARK: - Initializers
    open override func awakeFromNib() {
        super.awakeFromNib();
        configureInspectableProperties();
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews();
        configureAfterLayoutSubviews();
        
    }
    
    // MARK: - Private
    fileprivate func configureInspectableProperties() {
        
    }
    
    fileprivate func configureAfterLayoutSubviews() {
        configureFont();
        
    }
}
