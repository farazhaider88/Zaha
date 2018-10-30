//
//  ColorManager.swift


import UIKit

class ColorManager: BaseManager {
    private static var _sharedInstance: ColorManager = ColorManager();
    
    class override var sharedInstance: ColorManager {
        get {
            return self._sharedInstance;
        }
    }
    
    public class func color(forKey key: String?) -> UIColor? {
        return ColorManager.sharedInstance.color(forKey: key);
    }
    
    func color(forKey key: String?) -> UIColor? {
        if let hexColor:String = super.objectForKey(key) {
            
            return UIColor(hexString: hexColor);
        } else {
            #if DEBUG
                assert(key == nil, "ColorManager> color key : \(key!) not found\n");
            #endif
            
            return nil;
        }
    }
}
