//
//  BaseManager.swift


import UIKit

open class BaseManager: NSObject {
    
    private static var _sharedInstance: BaseManager = BaseManager();
    private var isIpad:Bool = false;
    public static var usingLanguageSpecificPlists:Bool = false;
    
    class var sharedInstance: BaseManager {
        get {
            return self._sharedInstance;
        }
    }
    
    private lazy var fileName: String = {
        
        // If it is FontManager and iPad then concatenate _iPad to the file name
        if self is FontManager, self.isIpad == true {
            return  "\(type(of: self))_iPad";
        }
        return  "\(type(of: self))";
    }()
    
    
    private var _dictData:NSMutableDictionary?
    internal var dictData:NSDictionary? {
        get {
            return _dictData;
        }
    }
    
    public class func objectForKey<T>(_ aKey: String?) -> T? {
        return self.sharedInstance.objectForKey(aKey);
    }
    
    internal func objectForKey<T>(_ aKey: String?) -> T? {
        guard (aKey != nil) else {
            return nil;
        }
        
        return _dictData?.object(forKey: aKey!) as? T;
        
    }
    
    override init() {
        
        super.init();
        
        self.setupPlistFile();
    }
    
    private func setupPlistFile() {
        
        self.isIpad = DesignUtility.isIPad;
        
        // Special case for FontManager
        if self is FontManager {
            var fullPathUrl = fileName;
            
            // Add language code to the file name if language specific plists are used
            if BaseManager.usingLanguageSpecificPlists {
                let lang = NSLocale.preferredLanguages[0]
                fullPathUrl =  "\(fileName)_\(lang)";
            }
            
            // Check if language specific FontManager file is present
            if let path = Bundle.main.path(forResource: fullPathUrl, ofType: "plist") {
                _dictData = NSMutableDictionary(contentsOf: URL(fileURLWithPath: path));
            }
                // Fall back to default FontManager plist if language specific file is not found
            else if let path  = Bundle.main.path(forResource: fileName, ofType: "plist") {
                _dictData = NSMutableDictionary(contentsOf: URL(fileURLWithPath: path));
            }
                // Throw error if default FontManager is not found
            else {
                assertionFailure("Unable to load plist \(fileName)")
            }
            
        }
            // Normal case for all other managers
        else {
            if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
                _dictData = NSMutableDictionary(contentsOf: URL(fileURLWithPath: path));
            }
            else {
                assertionFailure("Unable to load plist \(fileName)")
            }
        }
        
    }
    
}

