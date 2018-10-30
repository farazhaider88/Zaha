//
//  GlobalStatic.swift


import UIKit
open class GlobalStatic {
    
    static func getFormatedAddress(add: String) -> String {
        let addArr = add.components(separatedBy: "|")
        var addString = addArr[0]
        for i in 1..<addArr.count {
            if !addArr[i].isEmptyStr() {
            addString = addString + ", " + addArr[i]
            }
        }
        return addString
    }
    
    
    
   open class func getLocalizedString(_ key : String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    
 
    
  class func createAttributedString(fullString: String, boldStringArray: [String]) -> NSMutableAttributedString
    {
        
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.0)]
        
        let attributedString = NSMutableAttributedString(string:fullString)
        for ind in 0..<boldStringArray.count {
            
            let range = (fullString as NSString).range(of: boldStringArray[ind])
            attributedString.addAttributes(boldFontAttribute, range: range)
            
            
        }
        
        return attributedString
    }
    
   
    
    static func delay(delay:Double, closure:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    
}

extension UILabel {
    
    func colorString(text: String?, coloredText: String?, color: UIColor? = .red) {
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: DesignUtility.getFontSize(fSize: 16))]
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: coloredText!)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color!],
                                       range: range)
         attributedString.addAttributes(boldFontAttribute, range: range)
        
        self.attributedText = attributedString
}
}


