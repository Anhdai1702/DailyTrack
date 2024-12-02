//
//  HeaderCreateView.swift
//  DailyTrackTestApp
//
//  Created by Phùng Anh Đài  on 14/11/24.
//

import UIKit

protocol HeaderCreateViewDelegate: AnyObject {
    func didTapSelectIcon()
}

class HeaderCreateView: NibView {
    // MARK: - Outlets
    @IBOutlet private weak var themeImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Variables
    weak var delegate: HeaderCreateViewDelegate?
    
    // MARK: - Life cycles
    override func configureView() {
        super.configureView()
    }
}

// MARK: - Actions
extension HeaderCreateView {
    
    @IBAction func didTapSelectIcon(_ sender: Any) {
        self.delegate?.didTapSelectIcon()
    }
}
