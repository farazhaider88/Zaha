//
//  AttributedLabel.swift


import Foundation

class AttributedLabel : BaseUILabel{
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let myString = self.text
//        let myAttribute = ""
//        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
//
//        // set attributed text on a UILabel
//        self.attributedText = myAttrString
        
        self.font = self.font.withSize(40)
    }
    
    
  
}
