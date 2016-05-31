//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Vasyl Kotsiuba on 2/8/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    
    override func shouldRemovePresentersView() -> Bool {
        return false
    }
    
    //The presentationTransitionWillBegin() method is invoked when the new view controller is about to be shown on the screen
    override func presentationTransitionWillBegin() {
        
        //The container view is a new view that is placed on top of the SearchViewController
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, atIndex: 0)
        
        dimmingView.alpha = 0
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ _ -> Void in
                self.dimmingView.alpha = 1
                }, completion: nil)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ _ -> Void in
                self.dimmingView.alpha = 0
                }, completion: nil)
        }
    }
}
