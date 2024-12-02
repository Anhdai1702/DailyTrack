//
//  SegmentCustomView.swift
//  dailytrack
//
//  Created by HieuMice on 28/9/24.
//

import UIKit

protocol SegmentCustomDelegate: AnyObject {
    func didTapItemAt(_ index: Int)
}

class SegmentCustomView: UIView {
    // Outlets
    @IBOutlet private weak var animateView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var leadingAnimationConstraint: NSLayoutConstraint!
    @IBOutlet private weak var widthAnimationConstraint: NSLayoutConstraint!
    
    // Variables
    var isAnimate: Bool = false
    var segmentItems: [SegmentModel] = [] {
        didSet {
            loadData()
            widthAnimationConstraint.constant = getWithItemCell()
            let selectedIndex = segmentItems.firstIndex(where: { $0.isSelected }) ?? 0
            updateLeadingAnimateView(selectedIndexPath: IndexPath(row: selectedIndex, section: 0))
        }
    }
    weak var segmentCustomDelegate: SegmentCustomDelegate?
    private let spacingCell: CGFloat = 12
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

//MARK: - Custom methods
extension SegmentCustomView {
    private func setupView() {
        loadView()
        self.layer.cornerRadius = self.frame.height / 2
        // 4: top and bottom collectionview - 2px
        animateView.layer.cornerRadius = (self.frame.height - 4) / 2
        animateView.backgroundColor = Constants.color1640D6
        self.backgroundColor = Constants.colorF5F6FAWithFourPercent
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomSegmentViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomSegmentViewCell")
    }
    
    private func loadView() {
        guard let view = self.loadViewFromNib(nibName: "SegmentCustomView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func loadData() {
        collectionView.reloadData()
    }
    
    private func updateLeadingAnimateView(selectedIndexPath: IndexPath) {
        let selectedIndex = CGFloat(selectedIndexPath.row)
        leadingAnimationConstraint.constant = selectedIndex * (self.getWithItemCell() + spacingCell)
    }
    
    private func getWithItemCell() -> CGFloat {
        let totalItem = CGFloat(segmentItems.count)
        return (self.frame.width - (spacingCell  * (totalItem - 1))) / totalItem
    }
    
    private func handleLogicWhenSelectedItem(selectedIndexPath: IndexPath, isSendDelegate: Bool = true) {
        guard !isAnimate else { return }
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let `self` = self else { return }
            self.isAnimate = true
            let selectedIndex = CGFloat(selectedIndexPath.row)
            self.animateView.frame.origin.x = selectedIndex * (self.getWithItemCell() + spacingCell)
        } completion: { [weak self] _ in
            if isSendDelegate {
                self?.segmentCustomDelegate?.didTapItemAt(selectedIndexPath.row)
            }
            self?.isAnimate = false
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let indexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) {
            handleLogicWhenSelectedItem(selectedIndexPath: indexPath)
        }
    }
}

//MARK: - UICollectionViewDatasource, UICollectionViewDelegate
extension SegmentCustomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomSegmentViewCell", for: indexPath) as! CustomSegmentViewCell
        cell.updateDataWith(segmentItems[indexPath.row].title)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        cell.contentView.addGestureRecognizer(tapGesture)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: getWithItemCell(), height: collectionView.frame.height)
    }
}
