//
//  AddHabitViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 9/11/24.
//

import Foundation
import UIKit

class AddHabitViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var breakBadHabitView: UIView!
    @IBOutlet private weak var createGoodHabitView: UIView!
        
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension AddHabitViewController {
    
    @IBAction func didTapBadHabit(_ sender: Any) {
        let vc = NewHabitViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapGoodHabit(_ sender: Any) {
        let vc = NewHabitViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Custom Methods
extension AddHabitViewController {
    
    private func setupUI() {
        self.view.addBlurColor()
        breakBadHabitView.backgroundColor = Constants.colorF5F6FAWithFourPercent
        createGoodHabitView.backgroundColor = Constants.colorF5F6FAWithFourPercent
    }
}
