//
//  CategoryCollectionViewCell.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 13.01.2024.
//

import Foundation
import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    //MARK: -variables-
    static let identifier = "CategoryCollectionViewCell"
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        label.backgroundColor = .white
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4).cgColor
        label.layer.cornerRadius = 20
        return label
    }()
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDeselectedAppearance()
    }
    
    //MARK: -Functions-
    func configure(with name: String) {
        nameLabel.text = name
        setDeselectedAppearance()
    }
    
    func setSelectedAppearance() {
        nameLabel.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
        nameLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
        nameLabel.layer.borderWidth = 0
        nameLabel.layer.cornerRadius = 20
        nameLabel.clipsToBounds = true
    }

    func setDeselectedAppearance() {
        nameLabel.backgroundColor = .clear
        nameLabel.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        nameLabel.layer.cornerRadius = 20
        nameLabel.clipsToBounds = true
   }
}

//MARK: -SetUpViews-
extension CategoryCollectionViewCell {
    private func setUpViews() {
        contentView.addSubview(nameLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
