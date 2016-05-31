//
//  SlideOutAnimationController.swift
//  StoreSearch
//
//  Created by Vasiliy Kotsiuba on 12/02/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit


class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            let containerView = transitionContext.containerView() {
                
                let duration = transitionDuration(transitionContext)
                UIView.animateWithDuration(duration, animations: {
                    fromView.center.y -= containerView.bounds.size.height
                    fromView.transform = CGAffineTransformMakeScale(0.5, 0.5)
                    }, completion: { finished in
                        transitionContext.completeTransition(finished)
                })
        }
    }
}