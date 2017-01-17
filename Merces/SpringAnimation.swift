//
//  SpringAnimation.swift
//  ShotsDemo
//
//  Created by Meng To on 2014-07-04.
//  Copyright (c) 2014 Meng To. All rights reserved.
//

import UIKit

var duration = 0.7
var delay = 0.0
var damping = 0.7
var velocity = 0.7

func spring(_ duration: TimeInterval, animations: (() -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: delay as TimeInterval, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        animations()
        
    }, completion: { finished in
        
        
    })
    
}

// Personal Spring
func springForKeypadButtonsPressed (sender: UIButton, animations: (() -> Void)!) {
    
    UIView.animate(withDuration: 0.1, delay: delay, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        animations()
        
    }, completion: { finished in
        
        sender.transform = CGAffineTransform.identity
        
    })
}

// Personal Spring
func springForInputViews(_ duration: TimeInterval, animations:(() -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        animations()
        
    }, completion: { finished in
        
    })
    
}

func springComplete(_ duration: TimeInterval, animations: (() -> Void)!, completion: ((Bool) -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        animations()
        
    }, completion: { finished in
        completion(true)
    })
}

func springForTotaledAmountsViews(_ duration: TimeInterval, animations:(() -> Void)!, completion: ((Bool) -> Void)!) {
    
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        animations()
        
    }, completion: { finished in
        completion(true)
    })
    
}


func springScaleFrom (_ view: UIView, x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat) {
    let translation = CGAffineTransform(translationX: x, y: y)
    let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
    view.transform = translation.concatenating(scale)
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        let translation = CGAffineTransform(translationX: 0, y: 0)
        let scale = CGAffineTransform(scaleX: 1, y: 1)
        view.transform = translation.concatenating(scale)
        
    }, completion: nil)
}

func springScaleTo (_ view: UIView, x: CGFloat, y: CGFloat, scaleX: CGFloat, scaleY: CGFloat) {
    let translation = CGAffineTransform(translationX: 0, y: 0)
    let scale = CGAffineTransform(scaleX: 1, y: 1)
    view.transform = translation.concatenating(scale)
    
    UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        let translation = CGAffineTransform(translationX: x, y: y)
        let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
        view.transform = translation.concatenating(scale)
        
    }, completion: nil)
}

func popoverTopRight(_ view: UIView) {
    view.isHidden = false
    let translate = CGAffineTransform(translationX: 200, y: -200)
    let scale = CGAffineTransform(scaleX: 0.3, y: 0.3)
    view.alpha = 0
    view.transform = translate.concatenating(scale)
    
    UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
        
        let translate = CGAffineTransform(translationX: 0, y: 0)
        let scale = CGAffineTransform(scaleX: 1, y: 1)
        view.transform = translate.concatenating(scale)
        view.alpha = 1
        
    }, completion: nil)
    
}
