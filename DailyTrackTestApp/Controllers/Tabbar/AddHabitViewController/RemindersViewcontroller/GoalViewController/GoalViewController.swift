//
//  GoalViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 28/11/24.
//

import UIKit

class GoalViewController: UIViewController {
    
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var customView: UIView!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var minAndTimeTableView: UITableView!
    @IBOutlet private weak var perTableView: UITableView!
    @IBOutlet private weak var timeView: TimeView!
    @IBOutlet private weak var perDayView: PerDayView!
    @IBOutlet private weak var goalItems: UIView!
    
    private var isSelect = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension GoalViewController {
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapShowMinAndTime(_ sender: Any) {
        isSelect.toggle()
        timeView.isHidden = isSelect ? false : true
    }
    
    @IBAction func didTapShowPer(_ sender: Any) {
        isSelect.toggle()
        perDayView.isHidden = isSelect ? false : true
    }
}

// MARK: Custom methods
extension GoalViewController {
    
    private func setupUI() {
        setupView()
    }
    
    private func setupView() {
        goalItems.backgroundColor = UIColor(resource: .goal)
        timeView.isHidden = true
        perDayView.isHidden = true
    }
}
