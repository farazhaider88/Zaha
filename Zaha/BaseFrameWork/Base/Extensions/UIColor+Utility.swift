import UIKit

// USAGE: AppColor.lightBlue.value
public enum AppColor {
    case lightBlue
    case orange
    case purple
    case gray
}

public extension AppColor {
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .lightBlue:
            instanceColor = UIColor(hexString: "ffff03")
        case .orange:
            instanceColor = UIColor(hexString: "ffff03")
        case .purple:
            instanceColor = UIColor(hexString: "ffff03")
        case .gray:
            instanceColor = UIColor(hexString: "ffff03")
        
        }
        
        return instanceColor
        
    }
}

public extension UIColor {
    
    public static var theme:UIColor! {
        get {
            return ColorManager.sharedInstance.color(forKey: "theme");
        }
    }
    
    public static var primary:UIColor! {
        get {
            return ColorManager.sharedInstance.color(forKey: "primary");
        }
    }
    
    public static var secondary:UIColor! {
        get {
             return ColorManager.sharedInstance.color(forKey: "secondary");
        }
    }
    
    public static var lightBlue:UIColor! {
        get {
            return UIColor(hexString: "ffff03")
        }
    }
    
    
    
    public class func color(forKey key: String?) -> UIColor! {
        return ColorManager.sharedInstance.color(forKey: key);
        
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (0,0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    convenience init(hexString: String, alpha : CGFloat) {
        let hex = hexString.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let  r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (_, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (_, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (_, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (_, r, g, b) = (0, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }

}
