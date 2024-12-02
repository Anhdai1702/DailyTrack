//
//  CustomSegmentViewCell.swift
//  dailytrack
//
//  Created by HieuMice on 28/9/24.
//

import UIKit

class CustomSegmentViewCell: UICollectionViewCell {
    // Outlet
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func updateDataWith(_ title: String) {
        titleLabel.text = title
        setupViews()
    }

    private func setupViews() {
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .white
    }
}
