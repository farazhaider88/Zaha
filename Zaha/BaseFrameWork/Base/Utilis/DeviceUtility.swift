//
//  DeviceUtility.swift


import UIKit

public enum Device: Int {
    case iPodTouch5,
    iPodTouch6,
    iPhone4,
    iPhone4s,
    iPhone5,
    iPhone5c,
    iPhone5s,
    iPhone6,
    iPhone6Plus,
    iPhone6s,
    iPhone6sPlus,
    iPhone7,
    iPhone7Plus,
    iPhone8,
    iPhone8Plus,
    iPhoneX,
    iPad2,
    iPad3,
    iPad4,
    iPadAir,
    iPadAir2,
    iPadMini,
    iPadMini2,
    iPadMini3,
    iPadMini4,
    iPadPro,
    appleTv,
    simulator,
    unknown;
    
}

public class DeviceUtility: NSObject {
    
    // Get the model name of device
    public class var modelName: Device {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return .iPodTouch5
        case "iPod7,1":                                 return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1":                               return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                  return .iPhone5
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5s
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6s
        case "iPhone8,2":                               return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        case "iPhone10,1", "iPhone10,3":                  return .iPhone8
        case "iPhone10,2", "iPhone10,4":                  return .iPhone8Plus
        case "iPhone10,5", "iPhone10,6":                  return .iPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPadAir
        case "iPad5,3", "iPad5,4":                      return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPadMini3
        case "iPad5,1", "iPad5,2":                      return .iPadMini4
        case "iPad6,7", "iPad6,8":                      return .iPadPro
        case "AppleTV5,3":                              return .appleTv
        case "i386", "x86_64":                          return .simulator
        default:                                        return .unknown
        }
    }
    
    // Check if the device is iPad
    public class func isIpad() -> Bool {
        return UIUserInterfaceIdiom.pad == UIDevice.current.userInterfaceIdiom;
    }
    
    // Get the size of the device screen
    public class func getSize() -> CGSize {
        
        var size : CGSize = CGSize(width: UIScreen.main.nativeBounds.size.width/UIScreen.main.scale, height: UIScreen.main.nativeBounds.size.height/UIScreen.main.scale)
        
        if(size.height == 640 && size.width  == 360){
            size = CGSize(width : 414, height : 736)
        }
        
        return size
    }
    
    // Get the device name from screen size
    public static func getDeviceType() -> Device
    {
        
        let height = UIScreen.main.nativeBounds.size.height
        
        switch height {
        case  960:
            return .iPhone4
        case  1136:
            return .iPhone5
        case  1334:
            return .iPhone6
        case  2208:
            return .iPhone6Plus
        case  2436:
            return .iPhoneX
        case  1024:
            return .iPadMini
        case  2048:
            return .iPad2
        case  2732:
            return .iPadPro
        default:
            return .unknown;
        }
    }
    
    // Check if the orientation is landscape
    public class func isLandscape() -> Bool
    {
        let orientation : UIInterfaceOrientation = UIApplication.shared.statusBarOrientation;
        
        if (orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            return true
        }
        return false
    }
    
    // Get the language of the device
    public class func getDeviceLanguage() -> String
    {
        let pre = NSLocale.preferredLanguages[0]
        
        return pre;
    }
    
    // Check if the device is jail broken or not
    public class func isJailBrokeDevice() -> Bool {
        #if arch(i386) || arch(x86_64)
            debugPrint("Simulator")
            return false
        #else
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(fileURLWithPath: "cydia://package/com.example.package")) // canOpenURL(URL(string:"cydia://package/com.example.package”)!)
                
            {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do
            {
                try stringToWrite.write(toFile:"/;;private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                //Device is jailbroken
                return true
            }catch
            {
                return false
            }
        #endif
    }
}
