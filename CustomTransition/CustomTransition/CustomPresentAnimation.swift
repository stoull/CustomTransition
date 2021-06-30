//
//  CustomPresentAnimation.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

class CustomPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(0.25)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        // let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true),
        guard let fromVC = transitionContext.viewController(forKey: .from) as? UINavigationController,
              let toVC = transitionContext.viewController(forKey: .to) as? SettingViewController
               else {
            // Add destination view if exception happend
            if let toView = transitionContext.view(forKey: .to) {
                containerView.addSubview(toView)
            }
            transitionContext.completeTransition(true)
            return
        }
        
        // Round corner before take the snapshot
        fromVC.view.layer.masksToBounds = true
        fromVC.view.layer.cornerRadius = 24
        guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else {
            return
        }
        
        
        
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        
        
        
        let containerFrame = containerView.frame
        let originalFrame = CGRect(x: 0.0, y: 0.0, width: snapshot.frame.size.width, height: snapshot.frame.size.height)
        let snapshotFinalPosition = CGPoint(x: containerFrame.size.width * (1 + 0.06), y: containerFrame.size.height * (0.5 + 0.02))
        
        // Animated the view in the 'toView' rather than container
        toVC.homeVCSnapshotView = snapshot
        toView.addSubview(snapshot)
        containerView.addSubview(toView)
        snapshot.frame = originalFrame
        toView.frame = originalFrame
        
        snapshot.layer.shadowColor = UIColor.black.cgColor
        snapshot.layer.masksToBounds = false;
        snapshot.layer.shadowOffset = CGSize(width: 0, height: 0);
        snapshot.layer.shadowRadius = 8;
        snapshot.layer.shadowOpacity = 0.6;
        
        let tapGesture = UITapGestureRecognizer(target: toVC, action: #selector(type(of: toVC).snapShotDidTap))
        snapshot.addGestureRecognizer(tapGesture)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0,
                                options: .calculationModeLinear) {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                snapshot.layer.position = snapshotFinalPosition
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                var scaleAndRotation = CATransform3DMakeScale(0.74, 0.74, 1.0)
                scaleAndRotation = CATransform3DRotate(scaleAndRotation, CGFloat(-(.pi * 0.05)), 0.0, 0.0, 1.0)
                snapshot.layer.transform = scaleAndRotation
            }
            
        } completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
