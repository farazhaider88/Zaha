//
//  ParallaxHeaderView.swift
//

import UIKit

protocol UpdateFrameDelegate : class {
    
    func updateFrame() -> Void
}

final class ParallaxHeaderView: UIView {
    
    fileprivate var heightLayoutConstraint = NSLayoutConstraint()
    fileprivate var bottomLayoutConstraint = NSLayoutConstraint()
    fileprivate var containerView = UIView()
    fileprivate var containerLayoutConstraint = NSLayoutConstraint()
    
   //--ww  fileprivate var homeTopView : HomeTopView!
    weak static var delegateScroll : UpdateFrameDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   private override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
      init(frame: CGRect , view : UIView) {
        super.init(frame: frame)
        
        setUpViews(homeTopView: view)
    }
    
    func setUpViews(homeTopView : UIView) {
        self.backgroundColor = .clear
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear
        
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        containerLayoutConstraint = NSLayoutConstraint(item: containerView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .height,
                                                       multiplier: 1.0,
                                                       constant: 0.0)
        self.addConstraint(containerLayoutConstraint)
        
        
        
        
        
        
        containerView.addSubview(homeTopView)
        
        
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[homeTopView]|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                    metrics: nil,
                                                                    views: ["homeTopView" : homeTopView]))
        
        bottomLayoutConstraint = NSLayoutConstraint(item: homeTopView,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(bottomLayoutConstraint)
        
        heightLayoutConstraint = NSLayoutConstraint(item: homeTopView,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .height,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(heightLayoutConstraint)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
        
        ParallaxHeaderView.delegateScroll?.updateFrame()
       
    }
}

