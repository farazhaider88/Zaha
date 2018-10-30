//
//  BaseUIButton.swift


import UIKit

open class BaseUIButton: UIButton, FontDesignable, CornerDesignable, BorderDesignable, MaskDesignable, FillDesignable, ShadowDesignable, ButtonImageDesignable {
    
    // MARK: - ButtonImageDesignable
    @IBInspectable open var applyHorizontalValues: Bool = false {
        didSet {
            configureButtonImage();
        }
    }
    
    @IBInspectable open var spaceValue: CGFloat = 0.0 {
        didSet {
            configureButtonImage();
        }
    }
    
    @IBInspectable open var titleOnLeft: Bool = false {
        didSet {
            configureButtonImage();
        }
    }
    
    @IBInspectable open var keepTextInCenter: Bool = true {
        didSet {
            configureButtonImage();
        }
    }
    
    
    @IBInspectable open var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            configureButtonImage();
        }
    }
    
    // MARK: - ShadowDesignable
    @IBInspectable open var shadowRadius: CGFloat = DefaultConfig.shared.defaultShadowRadius {
        
        didSet {
            configureDropShadow();
        }
    }
    
    @IBInspectable open var shadowOpacity: CGFloat = DefaultConfig.shared.defaultShadowOpacity {
        
        didSet {
            configureDropShadow();
        }
    }
    
    @IBInspectable open var hasDropShadow:Bool = false {
        didSet {
            configureDropShadow();
        }
    }
    
    @IBInspectable open var hasBaseWidthConstraint:Bool = false {
        didSet {
            configureDropShadow();
        }
    }
   
    
    // MARK: - FontDesignable
    @IBInspectable open var fontNameTheme:String? = DefaultConfig.shared.defaultFontName {
        
        didSet {
            configureFont();
        }
    }
    
    private var fontColor : UIColor? = nil
    private var fontSelectedColor : UIColor? = nil
    
    @IBInspectable open var fontColorTheme:String? = DefaultConfig.shared.defaultButtonFontColor  {
        
        didSet {
            
            fontColor = (fontColorTheme != nil && !(fontColorTheme?.isEmpty)!) ? ColorManager.color(forKey: fontColorTheme!) : UIColor.black;
            fontSelectedColor = fontColor
            self.setTitleColor(fontColor, for: .normal);
            //--wwconfigureFont();
        }
    }
    
    @IBInspectable open var fontSizeTheme:String? = DefaultConfig.shared.defaultFontSize  {
        didSet {
            configureFont();
        }
    }
    
    @IBInspectable open var fontColorSelectedTheme: String? = DefaultConfig.shared.defaultButtonSelectedFontColor {
        didSet {
            
            fontSelectedColor = (fontColorSelectedTheme != nil && !(fontColorSelectedTheme?.isEmpty)!) ? ColorManager.color(forKey: fontColorSelectedTheme!) : fontColor;
            
            
            //--ww  configureSelectedFont();
        }
    }
    
    // MARK: - CornerDesignable
    
    @IBInspectable open var isRounded: Bool = false {
        didSet {
            configureCornerRadius();
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
        didSet {
            configureCornerRadius();
        }
    }
    
    open var cornerSides: CornerSides  = .allSides {
        didSet {
            configureCornerRadius();
        }
    }
    
    //NOTE:- Possible values topleft, topright, bottomleft, bottomright
    @IBInspectable var _cornerSides: String? {
        didSet {
            cornerSides = CornerSides(rawValue: _cornerSides);
        }
    }
    
    // MARK: - BorderDesignable
    open var borderType: BorderType  = .solid {
        didSet {
            configureBorder();
        }
    }
    
    //NOTE:- Possible values solid, dash
    @IBInspectable var _borderType: String? {
        didSet {
            borderType = BorderType(string: _borderType);
        }
    }
    
    @IBInspectable open var borderThemeColor: String? {
        didSet {
            configureBorder();
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
        didSet {
            configureBorder();
        }
    }
    
    open var borderSides: BorderSides  = .AllSides {
        didSet {
            configureBorder();
        }
    }
    
    //NOTE:- Possible values Top, Right, Bottom, Left
    @IBInspectable var _borderSides: String? {
        didSet {
            borderSides = BorderSides(rawValue: _borderSides);
        }
    }
    
    
    private var bgColor : UIColor? = nil
    private var bgSelectedColor : UIColor? = nil
    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            
            let fillColor = UIColor.color(forKey: fillThemeColor);
            if fillColor == nil {
                #if DEBUG
                    assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
                #endif
                return;
            }else{
                bgColor = fillColor
                self.backgroundColor = bgColor
            }
            //--ww configureFillColor();
        }
    }
    
    @IBInspectable open var bgHighlightedColor: String? {
        didSet{
            
            let fillColor = UIColor.color(forKey: bgHighlightedColor);
            if fillColor == nil {
                #if DEBUG
                    assertionFailure("Fill color for key : \(String(describing: bgHighlightedColor)) not found\n")
                #endif
                return;
            }else{
                bgSelectedColor = fillColor
            }
            
        }
        
    }
    
    
    @IBInspectable open var opacity: CGFloat = CGFloat.nan {
        didSet {
            configureOpacity();
        }
    }
    
    
    // MARK: - MaskDesignable
    open var maskType: MaskType = .none {
        didSet {
            configureMask(previousMaskType: oldValue)
            configureBorder()
            
        }
    }
    
    /// The mask type used in Interface Builder. **Should not** use this property in code.
    @IBInspectable var _maskType: String? {
        didSet {
            maskType = MaskType(string: _maskType)
        }
    }
   
    //MARK: - Initializers
    open override func awakeFromNib() {
        super.awakeFromNib();
        self.isExclusiveTouch = true
        configureInspectableProperties();
        
        self.addTarget(self, action: #selector(self.highlight), for: .touchDown)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchDragOutside)
        self.addTarget(self, action: #selector(self.unhighlight), for: .touchCancel)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews();
        if applyHorizontalValues == true {
            configureButtonImage();
        }
        configureAfterLayoutSubviews();
        
    }
    
    // MARK: - Private
    fileprivate func configureInspectableProperties() {
        configureCornerRadius();
    }
    
    fileprivate func configureAfterLayoutSubviews() {
        configureMask(previousMaskType: maskType);
        configureCornerRadius();
        configureBorder();

    }
    
    @objc func unhighlight(){
        guard bgColor != nil else {
            
            return;
        }
        
        self.setTitleColor(fontColor, for: .normal);
        self.backgroundColor = bgColor
        
    }
    
    @objc func highlight(){
        
        guard bgSelectedColor != nil else {
            
            return;
        }
        
        self.setTitleColor(fontSelectedColor, for: .normal);
        self.backgroundColor = bgSelectedColor
    }
    
}
