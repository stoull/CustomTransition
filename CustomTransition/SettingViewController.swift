//
//  SettingViewController.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

class SettingViewController: UIViewController {
    
    var swipeDismissInteractionController: SwipeInteractionController?
    
    // The view pretend to the Home View
    var homeVCSnapshotView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        swipeDismissInteractionController = SwipeInteractionController(viewController: self, interactionSceenEdge: .right)
        
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func snapShotDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
