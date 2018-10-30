//
//  BaseUINavigationItem.swift


import UIKit

open class BaseUINavigationItem: UINavigationItem {
    
    public override init(title: String) {
        super.init(title: title);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib();
        
        self.updateView();
    }
    
    
    func updateView() {
     
    }

}
