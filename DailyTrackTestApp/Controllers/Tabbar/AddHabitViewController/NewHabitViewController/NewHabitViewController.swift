//
//  NewHabitViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 12/11/24.
//

import UIKit

class NewHabitViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var newHabitView: UIView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var bottomView: GradientView!
    @IBOutlet private weak var newHabitCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    private var listNewHabit = [NewHabitModel]()
    private let listGoodHabit =
    [
        NewHabitModel(titleNewHabit: "Set a To-do list", newHabitImage: UIImage(resource: .newHabitGoodHabit1)),
        NewHabitModel(titleNewHabit: "Time control", newHabitImage: UIImage(resource: .newHabitGoodHabit2)),
        NewHabitModel(titleNewHabit: "Save money", newHabitImage: UIImage(resource: .newHabitGoodHabit3)),
        NewHabitModel(titleNewHabit: "Learn English", newHabitImage: UIImage(resource: .newHabitGoodHabit4)),
        NewHabitModel(titleNewHabit: "Exercise time", newHabitImage: UIImage(resource: .newHabitGoodHabit5))
    ]
    
    private let listBadHabit =
    [
        NewHabitModel(titleNewHabit: "Limit gaming", newHabitImage: UIImage(resource: .newHabitBadHabit1)),
        NewHabitModel(titleNewHabit: "Limit shopping", newHabitImage: UIImage(resource: .newHabitBadHabit2)),
        NewHabitModel(titleNewHabit: "Limit screen time", newHabitImage: UIImage(resource: .newHabitBadHabit3)),
        NewHabitModel(titleNewHabit: "Limit internet", newHabitImage: UIImage(resource: .newHabitBadHabit4)),
        NewHabitModel(titleNewHabit: "Limit overthinking", newHabitImage: UIImage(resource: .newHabitBadHabit5))
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension NewHabitViewController {
    
    @IBAction func didTapCreate(_ sender: Any) {
        let vc = RemindersViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            listNewHabit = listGoodHabit
        case 1:
            listNewHabit = listBadHabit
        default: break
        }
        newHabitCollectionView.reloadData()
    }
}

// MARK: - Custom methods
extension NewHabitViewController {
    
    private func setupUI() {
        setupBorder()
        setupSegmentedControl()
        registerCell()
        listNewHabit = listGoodHabit

    }
    
    private func setupBorder() {
        newHabitView.setCornerRadius(25, corners: [.bottomLeft, .bottomRight])
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    

    private func registerCell() {
        newHabitCollectionView.setup(cellType: NewHabitCollectionViewCell.self, delegateAndDataSource: self)
    }
}

//MARK: - UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension NewHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listNewHabit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewHabitCollectionViewCell", for: indexPath) as? NewHabitCollectionViewCell else
        { return UICollectionViewCell() }
        cell.configureNewHabit(model: listNewHabit[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}
