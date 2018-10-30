//
//  CustomButton.swift


import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isExclusiveTouch = true
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: DesignUtility.getValueFromRatio(10), right: 0.0)
        
        self.titleLabel?.font = UIFont.init(name: "Poppins-Regular", size: DesignUtility.getFontSize(fSize: 18))
       // self.titleLabel?.font = UIFont.systemFont(ofSize: DesignUtility.getFontSize(fSize: 18))
    }

}
