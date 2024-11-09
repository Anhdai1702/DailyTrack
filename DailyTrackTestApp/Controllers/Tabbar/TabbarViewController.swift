//
//  TabbarViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 8/11/24.
//

import UIKit

class TabbarViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tabbarView: TabbarView!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Variable
    private var menuViewController : MenuViewController!
    private var bookViewController : BookViewController!
    private var timeViewController : TimeViewController!
    private var storeViewController : StoreViewController!
    private var addHabitViewController: AddHabitViewController!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        switchToMenu()
    }
}

// MARK: - Setup TabbarDelegate
extension TabbarViewController: TabbarDelegate {

    func didTapMenu() {
        switchToMenu()
    }
    
    func didTapBook() {
        switchToBook()
    }
    
    func didTapTime() {
        switchToTime()
    }
    
    func didTapStore() {
        switchToStore()
    }
    
    func didTapAddHabit() {
        switchToAddHabit()
    }
}

// MARK: - Custom Methods
extension TabbarViewController {
    
    private func setupViewControllers() {
        tabbarView.delegate = self
        menuViewController = MenuViewController()
        bookViewController = BookViewController()
        timeViewController = TimeViewController()
        storeViewController = StoreViewController()
        addHabitViewController = AddHabitViewController()
    }
    
    private func switchToMenu() {
        switchToViewController(menuViewController)
    }
    
    private func switchToBook() {
        switchToViewController(bookViewController)
    }
    
    private func switchToTime() {
        switchToViewController(timeViewController)
    }
    
    private func switchToStore() {
        switchToViewController(storeViewController)
    }
    
    private func switchToAddHabit() {
        switchToViewController(addHabitViewController)
    }
    
    private func switchToViewController(_ viewController: UIViewController) {
        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
}
