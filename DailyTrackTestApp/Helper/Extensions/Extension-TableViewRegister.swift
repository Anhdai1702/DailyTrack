//
//  Extension-Register.swift
//  Shiftdays
//
//  Created by Phùng Anh Đài  on 29/8/24.
//

import Foundation
import UIKit

extension UITableView {
    
    func setup<TableViewCell: UITableViewCell>(cellType: TableViewCell.Type, delegateAndDataSource: UIViewController) {
        let identifier = String(describing: cellType)
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.delegate = delegateAndDataSource as? UITableViewDelegate
        self.dataSource = delegateAndDataSource as? UITableViewDataSource
    }
}

extension UICollectionView {
    
    func setup<CollectionViewCell: UICollectionViewCell>(cellType: CollectionViewCell.Type, delegateAndDataSource: UICollectionViewDelegate & UICollectionViewDataSource) {
        let identifier = String(describing: cellType)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
        self.delegate = delegateAndDataSource
        self.dataSource = delegateAndDataSource
    }
}
