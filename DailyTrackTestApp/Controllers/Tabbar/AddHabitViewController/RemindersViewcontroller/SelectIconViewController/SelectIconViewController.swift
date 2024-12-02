//
//  SelectIconViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 16/11/24.
//

import UIKit

class SelectIconViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var selectIconView: UIView!
    @IBOutlet private weak var closeBtn: UIButton!
    @IBOutlet private weak var selectIconCollectionView: UICollectionView!
    
    // MARK: - Variables
    private let listIcon =
    [
        SelectIconModel(IconImage: .iconButton), SelectIconModel(IconImage: .iconButton1), SelectIconModel(IconImage: .iconButton2), SelectIconModel(IconImage: .iconButton3), SelectIconModel(IconImage: .iconButton4), SelectIconModel(IconImage: .iconButton5), SelectIconModel(IconImage: .iconButton6), SelectIconModel(IconImage: .iconButton7),
        SelectIconModel(IconImage: .iconButton8),
        SelectIconModel(IconImage: .iconButton9),
        SelectIconModel(IconImage: .iconButton10),
        SelectIconModel(IconImage: .iconButton11),
        SelectIconModel(IconImage: .iconButton12),
        SelectIconModel(IconImage: .iconButton13),
        SelectIconModel(IconImage: .iconButton14),
        SelectIconModel(IconImage: .iconButton15),
        SelectIconModel(IconImage: .iconButton16),
        SelectIconModel(IconImage: .iconButton17),
        SelectIconModel(IconImage: .iconButton18),
        SelectIconModel(IconImage: .iconButton19)
    ]
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions
extension SelectIconViewController {
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Custom mehthods
extension SelectIconViewController {
    
    private func setupUI(){
        setupBlur()
        registerCell()
    }
    
    private func setupBlur() {
        BlurManager.shared.applyBlurEffect(to: blurView,withStyle: .light,additionalViews: [selectIconView, closeBtn])
    }
    
    private func registerCell() {
        selectIconCollectionView.setup(cellType: SelectIconCollectionViewCell.self, delegateAndDataSource: self)
    }
}

// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SelectIconViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listIcon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectIconCollectionViewCell", for: indexPath) as? SelectIconCollectionViewCell else
        { return UICollectionViewCell() }
        cell.configureSelectIcon(model: listIcon[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 48, height: 48)
    }
}
