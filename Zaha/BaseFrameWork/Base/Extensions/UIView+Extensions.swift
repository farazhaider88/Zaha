//
//  UIView+Extensions.swift


import UIKit

extension UIView {
    
    
    func expandView (){
        
    let viewFrame = self.frame
        self.frame = CGRect(x:self.frame.origin.x, y:self.frame.origin.y , width :0 , height : self.frame.size.height )
     self.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = viewFrame
            self.layoutIfNeeded()
        }) { (v) in
            
        }
      }
    
    
     func flipFromRight() {
       self.isHidden = false
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            
        }) { (v) in
           // self.popInView(view: self)
        }
    }
    
    
    func popInView(view: UIView)  {
        
      UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
            view.alpha = 1
            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1);
            
            
            
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                
                view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
                
            }) { (finished) in
                
            }
            
        }
    }
    
    
    
    
    func slideViewFromLeftToRight(success : @escaping (()->())){
        
        let actualFrame = self.frame
        
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            self.frame.origin.x = actualFrame.width
        }) { (v) in
            success()
        }
        
        
    }
    
    
    
    func rotate() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = 1 * 2
        animation.repeatCount = Float.infinity

        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.layer.add(animation, forKey: animation.keyPath)
    }
    
    func stopAnimationAndFinish(){
        if let presentation = self.layer.presentation(){
            if let currentRotation = presentation.value(forKeyPath: "transform.rotation.z") as? CGFloat{
                
                var duration = 2.0
                
                //smooth out duration for change
                duration = Double((CGFloat(Double.pi * 2) - currentRotation))/(Double.pi * 2)
                self.layer.removeAllAnimations()
                
                let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                rotation.fromValue = currentRotation
                rotation.toValue = Double.pi * 2
                rotation.duration = duration * 2
                self.layer.add(rotation, forKey: "rotationAnimation")
                
            }
        }
    }
    
    
    
    func slideView (){
        
        let viewFrame = self.frame
        self.frame = CGRect(x:-self.frame.size.width, y:self.frame.origin.y , width :self.frame.size.width , height : self.frame.size.height )
        self.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = viewFrame
            self.layoutIfNeeded()
        }) { (v) in
            
        }
    }
    
    
    
    func popInFast(delay : CGFloat , multiplier : CGFloat){
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1);
        self.alpha = 0.0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.2, delay: TimeInterval(multiplier * delay), options: .curveLinear, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2);
            
            
            
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.1, delay: TimeInterval((multiplier / 2.0 ) * delay), options: .curveLinear, animations: {
                
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0);
                
            }) { (finished) in
                
            }
            
        }
    }
}

public class Animations {
    
     static func flipView(view : UIView){
       
        
        view.flipFromRight()
        
    }
    
     static func slideView (view : UIView){
        
        let viewFrame = view.frame
        view.frame = CGRect(x:-view.frame.size.width, y:view.frame.origin.y , width :view.frame.size.width , height : view.frame.size.height )
        view.isHidden = false
  
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            view.frame = viewFrame
        }) { _ in
            
        }
    }
    
    static func slideViewFast (view : UIView){
        
        let viewFrame = view.frame
        view.frame = CGRect(x:-view.frame.size.width, y:view.frame.origin.y , width :view.frame.size.width , height : view.frame.size.height )
        view.isHidden = false
        
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            view.frame = viewFrame
        }) { _ in
            
        }
    }
    
}
