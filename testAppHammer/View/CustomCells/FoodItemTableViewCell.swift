//
//  FoodItemTableViewCell.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import Foundation
import UIKit
import SnapKit

class FoodItemTableViewCell: UITableViewCell {
    //MARK: -Variables-
    static let identifier = "FoodItemTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    //MARK: -LifeCycle-
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
    func configure(with foodItem: FoodItem) {
        nameLabel.text = foodItem.label
    }
}

//MARK: -setUpViews extensions-
extension FoodItemTableViewCell {
    private func setUpViews() {
        contentView.addSubview(nameLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
}
