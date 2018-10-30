import UIKit

@objc public protocol FillDesignable: class {
    var fillThemeColor: String? { get set }
   @objc var opacity: CGFloat { get set }
}

extension FillDesignable where Self: UINavigationController {
    internal func configureFillColor() {
        guard fillThemeColor != nil, fillThemeColor?.isEmpty == false else {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        let fillColor = UIColor.color(forKey: fillThemeColor);
        if fillColor == nil {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }

        
        self.navigationBar.barTintColor = fillColor;
    }
}

extension FillDesignable where Self: UIView {
    internal func configureFillColor() {
        guard fillThemeColor != nil, fillThemeColor?.isEmpty == false else {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        let fillColor = UIColor.color(forKey: fillThemeColor);
        if fillColor == nil {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        if let fillColor = fillColor {
            backgroundColor = fillColor
        }
    }
    
    internal func configureOpacity() {
        if !opacity.isNaN && opacity >= 0 && opacity <= 1 {
            alpha = opacity
            
            // Make better performance
            isOpaque = opacity == 1
        }
    }
}

extension FillDesignable where Self: UITableViewCell {
    internal func configureFillColor() {
        
        guard fillThemeColor != nil, fillThemeColor?.isEmpty == false else {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        let fillColor = UIColor.color(forKey: fillThemeColor);
        if fillColor == nil {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        if let fillColor = fillColor {
            backgroundColor = fillColor
            contentView.backgroundColor = fillColor
        }
    }
}

extension FillDesignable where Self: UICollectionViewCell {
    internal func configureFillColor() {
        
        guard fillThemeColor != nil, fillThemeColor?.isEmpty == false else {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        let fillColor = UIColor.color(forKey: fillThemeColor);
        if fillColor == nil {
            #if DEBUG
                assertionFailure("Fill color for key : \(String(describing: fillThemeColor)) not found\n")
            #endif
            return;
        }
        if let fillColor = fillColor {
            backgroundColor = fillColor
            contentView.backgroundColor = fillColor
        }
    }
}

