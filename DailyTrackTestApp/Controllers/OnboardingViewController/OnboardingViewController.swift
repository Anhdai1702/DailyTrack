//
//  OnboardingViewController.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 6/11/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    // Constraints
    @IBOutlet private weak var onboardingSlideCollectionView: UICollectionView!
    @IBOutlet private weak var onboardingPageControl: UICollectionView!
    
    // Variable
    @IBOutlet private weak var desciptionLabel: UILabel!
    private var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Actions
extension OnboardingViewController {
    
    @IBAction func didTapNext(_ sender: Any) {
        if currentIndex < OnboardingSlide.allSlides.count - 1  {
            currentIndex += 1
            moveToItem(at: IndexPath(item: currentIndex, section: 0))
        }
        else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Custom methods
extension OnboardingViewController {
    
    private func setupUI() {
        registerCells()
        onboardingSlideCollectionView.isPagingEnabled = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        updateData()
    }
    
    private func registerCells() {
        onboardingSlideCollectionView.setup(cellType: OnboardingCollectionViewCell.self, delegateAndDataSource: self)
        onboardingPageControl.setup(cellType: OnboardingPageControlCollectionViewCell.self, delegateAndDataSource: self)
    }
    
    private func moveToItem(at indexPath: IndexPath) {
        onboardingSlideCollectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
        currentIndex = indexPath.item
        onboardingPageControl.reloadData()
        updateData()
    }
    
    private func updateData() {
        desciptionLabel.text = OnboardingSlide.allSlides[currentIndex].description
        onboardingPageControl.reloadData()
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingSlide.allSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == onboardingSlideCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setupData(OnboardingSlide.allSlides[indexPath.row])
            return cell
        }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingPageControlCollectionViewCell", for: indexPath) as? OnboardingPageControlCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.updateView(isSelect: currentIndex == indexPath.row)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == onboardingSlideCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: indexPath.row == currentIndex ? 20 : 6, height: 6)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentIndex = Int(scrollView.contentOffset.x / width)
        updateData()
    }
}
