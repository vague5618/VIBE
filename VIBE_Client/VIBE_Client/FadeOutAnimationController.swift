//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by Vasiliy Kotsiuba on 12/02/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit


class FadeOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) {
        
            let duration = transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, animations: {
                fromView.alpha = 0
                }, completion: { finished in
                    transitionContext.completeTransition(finished)
            })
        
    
        }
    }
    
}
