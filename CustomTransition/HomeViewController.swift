//
//  HomeViewController.swift
//  CustomTransition
//
//  Created by Hut on 2021/6/30.
//

import UIKit

class HomeViewController: UIViewController {
    let customeTranstion = CustomTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "=", style: .plain, target: self, action: #selector(type(of: self).showSettingView))
        
        // Adding left screen edge gesture to show Setting View
        let leftEdgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(showSettingView))
        leftEdgeGesture.edges = .left
        self.view.addGestureRecognizer(leftEdgeGesture)
    }


    @objc
    private func showSettingView() {
        let settingVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        settingVC.modalPresentationStyle = .fullScreen
//        let customeTranstion = CustomPresentTransition()
        settingVC.transitioningDelegate = customeTranstion
        self.present(settingVC, animated: true, completion: nil)
    }

    @IBAction func goSettingView(_ sender: Any) {
        let homeVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }

}
