import UIKit

/// Protocol for designing side image
public protocol SideImageDesignable: class {
    /**
     * The left image
     */
    var leftImage: UIImage? { get set }
    
    /**
     * Left padding of the left image, default value is CGFloat.nan
     */
    var leftImageLeftPadding: CGFloat { get set }
    
    /**
     * Right padding of the left image, default value is CGFloat.nan
     */
    var leftImageRightPadding: CGFloat { get set }
    
    /**
     * Top padding of the left image, default value is CGFloat.nan
     */
    var leftImageTopPadding: CGFloat { get set }
    
    /**
     * The right image
     */
    var rightImage: UIImage? { get set }
    
    /**
     * Left padding of the right image, default value is CGFloat.nan
     */
    var rightImageLeftPadding: CGFloat { get set }
    
    /**
     * Right padding of the right image, default value is CGFloat.nan
     */
    var rightImageRightPadding: CGFloat { get set }
    
    /**
     * Top padding of the right image, default value is CGFloat.nan
     */
    var rightImageTopPadding: CGFloat { get set }
}

extension SideImageDesignable where Self: BaseUITextField {
    
    internal func configureImages() {
        configureLeftImage()
        configureRightImage()
    }
}

fileprivate extension SideImageDesignable where Self: BaseUITextField {
    
    func configureLeftImage() {
        
        guard let leftImage = leftImage else {
            leftView = nil
            return
        }
        
        let sideView = makeSideView(with: leftImage,
                                    leftPadding: leftImageLeftPadding,
                                    rightPadding: leftImageRightPadding,
                                    topPadding: leftImageTopPadding)
        leftViewMode = .always
        leftView = sideView
    }
    
    func configureRightImage() {
        
        guard let rightImage = rightImage else {
            rightView = nil
            return
        }
        
        let sideView = makeSideView(with: rightImage,
                                    leftPadding: rightImageLeftPadding,
                                    rightPadding: rightImageRightPadding,
                                    topPadding: rightImageTopPadding)
        rightViewMode = .always
        rightView = sideView
    }
    
    func makeSideView(with image: UIImage, leftPadding: CGFloat, rightPadding: CGFloat, topPadding: CGFloat) -> UIView {
        
        let imageView = UIImageView(image: image)
       //--ww imageView.contentMode = .center
        
        // If not set, use 0 as default value
        var leftPaddingValue: CGFloat = 0.0
        if !leftPadding.isNaN {
            leftPaddingValue = leftPadding
        }
        
        // If not set, use 0 as default value
        var rightPaddingValue: CGFloat = 0.0
        if !rightPadding.isNaN {
            rightPaddingValue = rightPadding
        }
        if UIApplication.isRTL() {
            let rPadding = rightPaddingValue;
            rightPaddingValue = leftPaddingValue;
            leftPaddingValue = rPadding;
        }
        // If does not specify `topPadding`, then center it in the middle
        if topPadding.isNaN {
            imageView.frame.origin = CGPoint(x: leftPaddingValue, y: (bounds.height - imageView.bounds.height) / 2)
        } else {
            imageView.frame.origin = CGPoint(x: leftPaddingValue, y: topPadding)
        }
        
        let padding = rightPaddingValue + imageView.bounds.size.width + leftPaddingValue
        let sideView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: bounds.height))
        sideView.addSubview(imageView)
        return sideView
    }
}

extension UIApplication {
    class func isRTL() -> Bool{
        let lang = DeviceUtility.getDeviceLanguage()
        var otherLang : String?
        if let someLang = lang.components(separatedBy: "-").first{
            otherLang = someLang
        }
        
        if lang == "ar" || otherLang! == "ar"{
            return true
        }else {
            return false
        }
        
    }
}
