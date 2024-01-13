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
    
    let goodImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 15
        return img
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        lbl.font = UIFont(name: "SFUIDisplay-Semibold", size: 17)
        return lbl
    }()
    
    let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 0.665, green: 0.668, blue: 0.679, alpha: 1)
        lbl.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let orderBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("от 345 р", for: .normal)
        btn.setTitleColor(UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "SFUIDisplay-Regular", size: 13)
        btn.layer.cornerRadius = 6
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        btn.backgroundColor = .white
        return btn
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
        goodImage.image = UIImage(named: "default_image")

        if let imageUrlString = foodItem.image, let url = URL(string: imageUrlString) {
            goodImage.loadImage(from: url)
        }
        
        titleLbl.text = foodItem.label
        
        var descriptionText = ""
        if let energy = foodItem.nutrients.ENERC_KCAL {
            descriptionText += "Energy: \(energy) kcal\n"
        }
        if let protein = foodItem.nutrients.PROCNT {
            descriptionText += "Protein: \(protein) g\n"
        }
        if let fat = foodItem.nutrients.FAT {
            descriptionText += "Fat: \(fat) g\n"
        }
        if let carbs = foodItem.nutrients.CHOCDF {
            descriptionText += "Carbs: \(carbs) g"
        }
        descriptionLbl.text = descriptionText
    }
}

//MARK: -setUpViews extensions-
extension FoodItemTableViewCell {
    private func setUpViews() {
        addSubview(goodImage)
        addSubview(titleLbl)
        addSubview(descriptionLbl)
        addSubview(orderBtn)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        goodImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(132)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalTo(goodImage.snp.trailing).offset(32)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.leading.equalTo(goodImage.snp.trailing).offset(32)
        }
        
        orderBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
