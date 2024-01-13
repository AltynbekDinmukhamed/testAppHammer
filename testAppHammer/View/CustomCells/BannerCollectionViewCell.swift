//
//  BannerCollectionViewCell.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 13.01.2024.
//

import Foundation
import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    //MARK: -Variables-
    static let bannerCellIdentifier = "BannerCollectionViewCell"
    
    let bannerImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        return img
    }()
    
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
    func configure(with image: UIImage) {
        bannerImage.image = image
    }
}

//MARK: -setUpView extensions-
extension BannerCollectionViewCell {
    private func setUpViews() {
        layer.cornerRadius = 20
        addSubview(bannerImage)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        bannerImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
