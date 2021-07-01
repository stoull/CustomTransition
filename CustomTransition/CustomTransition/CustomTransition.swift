//
//  CustomTransition.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let settingVC = dismissed as? SettingViewController else {
            return nil
        }
        return CustomDismissAnimation(interactionController: settingVC.swipeDismissInteractionController)
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? CustomDismissAnimation,
              let interactionController = animator.interactionController,
              interactionController.interactionInprogress else {
            return nil
        }
        return interactionController
    }
}
