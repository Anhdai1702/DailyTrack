//
//  SplashViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 5/11/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var defaultStorage = DefaultsStorageImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToScreen()
    }
    
    private func navigateToScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = OnboardingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.defaultStorage.noFirstTimeLaunch = true
        }
    }
}
