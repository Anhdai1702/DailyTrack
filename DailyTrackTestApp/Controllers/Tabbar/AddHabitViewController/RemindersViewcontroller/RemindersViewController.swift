//
//  RemindersViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import UIKit

class RemindersViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var blurView: UIView!
    @IBOutlet private weak var remindersView: UIView!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var remindersTableView: UITableView!
    
    // MARK: - Variables
    private let listNewHabit = CreateNewHabit.allCases
    struct ConstantsCreateNewHabit {
        static let corner = CGFloat(10)
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension RemindersViewController {
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Custom methods
extension RemindersViewController {
    
    private func setupUI() {
        setupBlur()
        registerCell()
    }
    
    private func registerCell() {
        remindersTableView.register(UINib(nibName: "RemindersCustomViewTableViewCell", bundle: nil), forCellReuseIdentifier: "RemindersCustomViewTableViewCell")
        remindersTableView.delegate = self
        remindersTableView.dataSource = self
    }
    
    private func setupBlur() {
        BlurManager.shared.applyBlurEffect(to: blurView,withStyle: .light,additionalViews: [remindersView, closeBtn])
        remindersView.backgroundColor = Constants.color15151C
        remindersTableView.backgroundColor = Constants.color15151C
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RemindersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listNewHabit.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNewHabit[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RemindersCustomViewTableViewCell", for: indexPath) as? RemindersCustomViewTableViewCell else {
            return UITableViewCell()
        }
        cell.configureReminders(model: listNewHabit[indexPath.section].item[indexPath.row])
        cell.applyCornerRadius(for: indexPath, itemCount: listNewHabit[indexPath.section].item.count, radius: ConstantsCreateNewHabit.corner)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = HeaderCreateView()
            headerView.delegate = self
            return headerView
        case 1:
            return nil
        default:
            return UIView()
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 80 : (section == 1 ? 1 : UITableView.automaticDimension)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = CreateNewHabit.allCases[indexPath.section]
        switch section {
        case .setupNewHabit:
            switch indexPath.row {
            case 0:
                let vc = RepeatViewViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            case 1:
                let vc = GoalViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            case 2:
                let vc = TimeOfDayViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            default: break
            }
            
        case .startDate:
            if indexPath.row == 0 {
                let vc = StartDateViewController()
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
            }
        }
    }
}

extension RemindersViewController: HeaderCreateViewDelegate {
    func didTapSelectIcon() {
        let vc = SelectIconViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}
