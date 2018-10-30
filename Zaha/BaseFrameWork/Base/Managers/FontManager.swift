//
//  FontManager.swift


import UIKit

class FontManager: BaseManager {
    private static var _sharedInstance: FontManager = FontManager();
    
    class override var sharedInstance: FontManager {
        get {
            return self._sharedInstance;
        }
    }
    
    public class func style(forKey key: String) -> Float {
        return FontManager.sharedInstance.style(forKey: key);
    }
    
    private func style(forKey key: String) -> Float {
        if let fontSize:Float = super.objectForKey(key) {
            return fontSize;
        } else {
            #if DEBUG
                assertionFailure("FontManager> font style key : \(key) not found\n")
            #endif
            
            return 22;
        }
    }
    
    public class func constant<T>(forKey key: String?) -> T? {
        if let constantV:T = super.objectForKey(key) {
            return constantV;
        } else {
            #if DEBUG
                assert(key == nil, "FontManager> constant key : \(key!) not found\n");
            #endif
            
            return nil;
        }
    }
}
