//
//  ShadowDesignable.swift


import UIKit

public protocol ShadowDesignable: class {
    var shadowRadius: CGFloat { get set }
    var shadowOpacity: CGFloat { get set }
    var hasDropShadow: Bool { get set }
    var hasBaseWidthConstraint: Bool { get set }
}


public extension ShadowDesignable where Self: UIView {
    public func configureDropShadow() {
        if hasDropShadow == true {
            addDropShadow();
        }
        else {
            layer.shadowRadius = 0;
            layer.shadowPath = nil
        }
    }
    
    
    fileprivate func addDropShadow() {
        
        let path:UIBezierPath = UIBezierPath.init(rect: CGRect.init(x: 0, y: self.frame.height, width: hasBaseWidthConstraint == true ? DesignUtility.convertToRatio(self.bounds.width) : self.bounds.width, height: 2))
        
        let layer:CALayer = self.layer;
        layer.shadowPath = nil;
        layer.shadowColor = UIColor.black.cgColor;
        layer.shadowOffset = CGSize(width : 1, height : 1);
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowRadius = shadowRadius
        layer.shadowPath = path.cgPath
        
        layer.masksToBounds = false;
    }
}
