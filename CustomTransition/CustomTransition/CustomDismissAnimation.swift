//
//  CustomDismissAnimation.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

class CustomDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    let interactionController: SwipeInteractionController?
    
    init(interactionController: SwipeInteractionController?) {
      self.interactionController = interactionController
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? SettingViewController
        else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        let containerView = transitionContext.containerView
        
        // Animated the view in the 'fromView' rather than container
        containerView.addSubview(toView)
        containerView.addSubview(fromVC.view)
        
        let originalFrame = CGRect(x: 0.0, y: 0.0, width: containerView.frame.size.width, height: containerView.frame.size.height)
        
        toView.frame = CGRect(origin: CGPoint(x: containerView.frame.size.width*0.5, y: 0.0), size: originalFrame.size)
        fromView.frame = originalFrame

        let snapshotStartPosition = CGPoint(x: containerView.frame.size.width * 0.5, y: containerView.frame.size.height * 0.5)
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: .calculationModeCubic) {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                fromVC.homeVCSnapshotView.layer.transform = CATransform3DIdentity
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                fromVC.homeVCSnapshotView.layer.position = snapshotStartPosition
            }
            
        } completion: { isFinished in
            
            if !transitionContext.transitionWasCancelled {
                fromView.removeFromSuperview()
                // recover the homeview's original appearance
                toView.layer.transform = CATransform3DIdentity
                toView.frame = originalFrame
                toView.layer.shadowOffset = CGSize(width: 0, height: -3);
                toView.layer.shadowRadius = 0;
                toView.layer.shadowOpacity = 0;
                toView.layer.masksToBounds = false;
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
}
