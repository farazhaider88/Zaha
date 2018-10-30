import UIKit

public protocol PlaceholderDesignable: class {
    
    var placeholderThemeColor: String? { get set }
    var placeholderTxt: String? { get set }
}

extension PlaceholderDesignable where Self: BaseUITextField {
    
    public var placeholderTxt: String? { get { return "" } set {} }
    
    internal func configurePlaceholderColor() {
        if placeholderThemeColor == nil {
            placeholderThemeColor = "black";
        }
        
        let placeholderColor:UIColor? = UIColor.color(forKey: placeholderThemeColor);
        
        let text = placeholder ?? placeholderTxt
        if let placeholderColor = placeholderColor, let placeholder = text {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }
    }
}

extension PlaceholderDesignable where Self: BaseUITextView {
    
    internal func configure(placeholderLabel: UILabel, placeholderLabelConstraints: inout [NSLayoutConstraint]) {
        
        if placeholderThemeColor == nil {
            placeholderThemeColor = "black";
        }
        
        let placeholderColor:UIColor? = UIColor.color(forKey: placeholderThemeColor);
        
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholderTxt
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        update(placeholderLabel, using: &placeholderLabelConstraints)
    }
    
    internal func update(_ placeholderLabel: UILabel, using constraints: inout [NSLayoutConstraint]) {
        
        var format = "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]-(\(textContainerInset.left + textContainer.lineFragmentPadding))-|"
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: format,
                                                            options: [], metrics: nil,
                                                            views: ["placeholder": placeholderLabel])
        
        format = "V:|-(\(textContainerInset.top))-[placeholder]"
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: format,
                                                         options: [], metrics: nil,
                                                         views: ["placeholder": placeholderLabel])
        
        let constant = -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        newConstraints.append(NSLayoutConstraint(item: placeholderLabel,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .width,
                                                 multiplier: 1.0,
                                                 constant: constant))
        
        removeConstraints(constraints)
        addConstraints(newConstraints)
        constraints = newConstraints
    }
    
}

