//
//  BaseUICollectionView.swift


import UIKit

open class BaseUICollectionView: UICollectionView, FillDesignable {

    // MARK: - FillDesignable
    @IBInspectable open var fillThemeColor: String? {
        didSet {
            configureFillColor();
        }
    }
    
    
    @IBInspectable open var opacity: CGFloat = CGFloat.nan {
        didSet {
            configureOpacity();
        }
    }
    

}
