//
//  BaseUIImageView.swift


import UIKit

open class BaseUIImageView: UIImageView , CornerDesignable, BorderDesignable, MaskDesignable, FillDesignable, ShadowDesignable {
    
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
    
    
    // MARK: - MaskDesignable
    open var maskType: MaskType = .none {
        didSet {
            configureMask(previousMaskType: oldValue);
            configureBorder();
            
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
        configureInspectableProperties();
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews();
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

}
