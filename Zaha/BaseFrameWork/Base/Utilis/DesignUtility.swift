//
//  DesignUtility.swift


import UIKit

public class DesignUtility: NSObject {
    
    @nonobjc static let deviceRatio:CGFloat = UIScreen.main.bounds.height / 736.0;
    @nonobjc static let deviceRatioWN:CGFloat = (UIScreen.main.bounds.height - 64.0) / (736.0 - 64.0); // Ratio with Navigation
    
    /// Bool flag for device type.
    @nonobjc public static let isIPad:Bool = UIDevice.current.userInterfaceIdiom == .pad;
    
    
    // addition  to set layout on iPhone X (Dimensions: 1125px x 2436px (375pt x 812pt @3x).)
    @nonobjc static let deviceRatioIphone:CGFloat =
        (UIScreen.main.bounds.height > 736.0 ? 667.0 : UIScreen.main.bounds.height ) / 736.0;
    
    @nonobjc static let deviceRatioIpad:CGFloat = UIScreen.main.bounds.height / 1366.0;
    
    
    public class func getValueFromRatio(_ value:CGFloat) ->CGFloat
    {
        
        if (DesignUtility.isIPad ) {
            return (value * DesignUtility.deviceRatioIpad)
        }else{
            return (value * (DesignUtility.deviceRatioIphone == 0 ? 1 : DesignUtility.deviceRatioIphone ))
        }
    }
    
    //Getting font size with minimum range
    
    public class func getFontSize(fSize : CGFloat) ->CGFloat{
        var minFontSize:CGFloat = 0;
        
        minFontSize = CGFloat.init(FontManager.style(forKey: "minimumFontSize"))
        
        //var resizedFontSize = DesignUtility.convertToRatio(fSize, sizedForIPad: DesignUtility.isIPad, sizedForNavi: false);
        
        var resizedFontSize = DesignUtility.getValueFromRatio(fSize)
        
        if resizedFontSize < minFontSize {
            resizedFontSize = minFontSize;
        }
        
        return resizedFontSize
    }
    
    /// Flag to check user interfce layout direction
    @nonobjc public static var isRTL:Bool  {
        get {
            return false;
        }
    }
    
    public class func convertToRatioSizedForNavi(_ value:CGFloat) -> CGFloat {
        return self.convertToRatio(value, sizedForIPad: false, sizedForNavi:true);
    }
    
    public class func convertToRatio(_ value:CGFloat, sizedForIPad:Bool = false, sizedForNavi:Bool = false) -> CGFloat {
        
        if (DesignUtility.isIPad && !sizedForIPad) {
            return value;
        }
        if (sizedForNavi) {
            return value * DesignUtility.deviceRatioWN; // With Navigation
        }
        
        return value * DesignUtility.deviceRatio;
    }
    
    
    
    
    public class func convertPointToRatio(_ value:CGPoint, sizedForIPad:Bool = false) -> CGPoint {
        return CGPoint(x:self.convertToRatio(value.x, sizedForIPad: sizedForIPad), y:self.convertToRatio(value.y, sizedForIPad: sizedForIPad));
    }
    
    public class func convertSizeToRatio(_ value:CGSize, sizedForIPad:Bool = false) -> CGSize {
        return CGSize(width:self.convertToRatio(value.width, sizedForIPad: sizedForIPad), height:self.convertToRatio(value.height, sizedForIPad: sizedForIPad));
    }
    
}

