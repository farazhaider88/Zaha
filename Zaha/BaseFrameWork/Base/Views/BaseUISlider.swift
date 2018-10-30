//
//  BaseUISlider.swift


import UIKit

open class BaseUISlider: UISlider {
    
    @IBInspectable open var minColorStyle:String? = nil {
        didSet {
            self.minimumTrackTintColor = ColorManager.color(forKey: minColorStyle);
        }
    }
    
    @IBInspectable open var maxColorStyle:String? = nil {
        didSet {
            self.maximumTrackTintColor = ColorManager.color(forKey: maxColorStyle);
        }
    }
    
    @IBInspectable open var thumbColorStyle:String? = nil {
        didSet {
            self.thumbTintColor = ColorManager.color(forKey: thumbColorStyle);
        }
    }
    
    //MARK: - Overridden Methods
    override open func awakeFromNib() {
        super.awakeFromNib();
        
        configureView();
    }
    
    //MARK: - Methods
    func configureView() {
        
        if let minCStyle = self.minColorStyle {
            self.minColorStyle = minCStyle;
        }
        
        if let maxCStyle = self.maxColorStyle {
            self.maxColorStyle = maxCStyle;
        }
        
        if let thumbCStyle = self.thumbColorStyle {
            self.thumbColorStyle = thumbCStyle;
        }
        
    }
}
