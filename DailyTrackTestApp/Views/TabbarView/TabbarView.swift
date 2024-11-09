//
//  TabbarView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 8/11/24.
//

import UIKit

protocol TabbarDelegate: AnyObject {
    func didTapMenu()
    func didTapBook()
    func didTapTime()
    func didTapStore()
    func didTapAddHabit()
}

class TabbarView: NibView {
    //MARK: - Outlets
    @IBOutlet private weak var moveBarMenuImage: UIImageView!
    @IBOutlet private weak var moveBarBookImage: UIImageView!
    @IBOutlet private weak var moveBarTimeImage: UIImageView!
    @IBOutlet private weak var moveBarStoreImage: UIImageView!
    @IBOutlet private weak var menuBtn: UIButton!
    @IBOutlet private weak var bookBtn: UIButton!
    @IBOutlet private weak var timeBtn: UIButton!
    @IBOutlet private weak var storeBtn: UIButton!
    @IBOutlet private weak var addHabit: UIButton!
    
    //MARK: - Variable
    weak var delegate: TabbarDelegate?
    
    //MARK: - life Cycles
    override func configureView() {
        super.configureView()
        setupUI()
    }
}

//MARK: - Actions
extension TabbarView {
    
    @IBAction func didTapMenu(_ sender: Any) {
        self.delegate?.didTapMenu()
        setupMenu()
    }
    
    @IBAction func didTapBook(_ sender: Any) {
        self.delegate?.didTapBook()
        setupBook()
    }
    
    @IBAction func didTapTime(_ sender: Any) {
        self.delegate?.didTapTime()
        setupTime()
    }
    
    @IBAction func didTapStore(_ sender: Any) {
        self.delegate?.didTapStore()
        setupStore()
    }
    
    @IBAction func didTapAddHabit(_ sender: Any) {
        self.delegate?.didTapAddHabit()
        setupAddHabit()
    }
}

//MARK: - Custom methods
extension TabbarView {
    
    private func setupUI() {
        setupImageIsHidden()
        setupImageBtn()
        setupTabbar(section: 1)
    }
    
    private func setupImageIsHidden() {
        moveBarMenuImage.isHidden = true
        moveBarBookImage.isHidden = true
        moveBarTimeImage.isHidden = true
        moveBarStoreImage.isHidden = true
    }
    
    private func setupImageBtn() {
        menuBtn.setImage(UIImage(resource: .tabbarMenudidselect), for: .normal)
        bookBtn.setImage(UIImage(resource: .tabbarBookDidselect), for: .normal)
        timeBtn.setImage(UIImage(resource: .tabbarTimeDidselect), for: .normal)
        storeBtn.setImage(UIImage(resource: .tabbarStoreDidselect), for: .normal)
    }
    
    private func setupTabbar(section: Int) {
        setupImageIsHidden()
        setupImageBtn()
        switch section {
        case 1:
            moveBarMenuImage.isHidden = false
            menuBtn.setImage(UIImage(resource: .tabbarMenuSelect), for: .normal)
        case 2:
            moveBarBookImage.isHidden = false
            bookBtn.setImage(UIImage(resource: .tabbarBookSelect), for: .normal)
        case 3:
            moveBarTimeImage.isHidden = false
            timeBtn.setImage(UIImage(resource: .tabbarTimeSelect), for: .normal)
        case 4:
            moveBarStoreImage.isHidden = false
            storeBtn.setImage(UIImage(resource: .tabbarStoreSelect), for: .normal)
        case 5:
            setupImageIsHidden()
            setupImageBtn()
        default:
            break
        }
    }
    
    private func setupMenu() {
        self.delegate?.didTapMenu()
        setupTabbar(section: 1)
    }
    
    private func setupBook() {
        self.delegate?.didTapBook()
        setupTabbar(section: 2)
    }
    
    private func setupTime() {
        self.delegate?.didTapTime()
        setupTabbar(section: 3)
    }
    
    private func setupStore() {
        self.delegate?.didTapStore()
        setupTabbar(section: 4)
    }
    
    private func setupAddHabit() {
        setupTabbar(section: 5)
    }
}
