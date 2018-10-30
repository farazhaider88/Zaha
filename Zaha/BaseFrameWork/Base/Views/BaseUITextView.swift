//
//  BaseUITextView.swift


import UIKit
import MOLH

open class BaseUITextView: UITextView, FontDesignable, CornerDesignable, BorderDesignable, PlaceholderDesignable, FillDesignable, ShadowDesignable {
    
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
    

    open var placeholderLabel: UILabel = UILabel()
    
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

    
    // MARK: - PlaceholderDesignable
    @IBInspectable open var placeholderTxt: String? {
        didSet {

            placeholderLabel.text = placeholderTxt
            placeholderLabel.tag = -1
         }
    }
    
    @IBInspectable open var placeholderThemeColor: String? {
        didSet {
            if placeholderThemeColor == nil {
                placeholderThemeColor = "black";
            }
            
            let placeholderColor:UIColor? = UIColor.color(forKey: placeholderThemeColor);

            placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK: Override properties
    override open var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    open override var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            update(placeholderLabel, using: &placeholderLabelConstraints)
        }
    }
    
    // MARK: Private properties
    fileprivate var placeholderLabelConstraints = [NSLayoutConstraint]()
    
   
    
    //MARK: - Initializers
    open override func awakeFromNib() {
        super.awakeFromNib();
        configureInspectableProperties();
        
        let value = DesignUtility.getValueFromRatio(15)
        self.textContainerInset = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
        
        if MOLHLanguage.currentAppleLanguage() == "en" {
            self.textAlignment = .left
        }else{
            self.textAlignment = .right
        }
    }
    
  
    
    open override func layoutSubviews() {
        super.layoutSubviews();
        configureAfterLayoutSubviews();
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // MARK: - Private
    private func configureInspectableProperties() {
        configure(placeholderLabel: placeholderLabel, placeholderLabelConstraints: &placeholderLabelConstraints)
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    @objc
    private func textDidChange() {
        
        placeholderLabel.isHidden = !text.isEmpty
        print(placeholderLabel.isHidden ? "true" : "false")
        print(placeholderLabel.frame)
        
    }
    
    private func configureAfterLayoutSubviews() {
        configureCornerRadius()
        configureBorder()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }


}
