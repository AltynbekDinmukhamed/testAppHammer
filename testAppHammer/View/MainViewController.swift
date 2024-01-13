//
//  ViewController.swift
//  testAppHammer
//
//  Created by Димаш Алтынбек on 12.01.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    //MARK: -Variables-
    var presenter: MainViewPresenterProtocol!
    
    private lazy var citySelectorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Москва ", for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.tintColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 17)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(cityButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.bannerCellIdentifier)
        return collectionView
    }()
    
    private var categoryCollectionViewTopConstraint: Constraint?
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collection
    }()
    
    let mainTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.layer.cornerRadius = 20
        table.register(FoodItemTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        presenter.getFoodItems()
    }

    //MARK: -Function-

}

//MARK: -SetUpViewExtensions-
extension MainViewController {
    private func setUpViews() {
        view.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        view.addSubview(citySelectorButton)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(mainTable)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        mainTable.dataSource = self
        mainTable.delegate = self
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        citySelectorButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
        }
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(citySelectorButton.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(112)
        }
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.snp.makeConstraints { make in
            self.categoryCollectionViewTopConstraint = make.top.equalTo(bannerCollectionView.snp.bottom).offset(24).constraint
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
                
        mainTable.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.left.bottom.right.equalToSuperview()
        }
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        mainTable.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: -categoryCollectionView data source methods-
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.bannerCollectionView {
            return 2
        } else if collectionView == self.categoryCollectionView {
            return presenter.categories.count
        } else {
            fatalError("Unexpected collectionView")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.bannerCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.bannerCellIdentifier, for: indexPath) as! BannerCollectionViewCell
            let imageName = indexPath.row == 0 ? "firstBanner" : "secoundBanner"
            if let image = UIImage(named: imageName) {
                cell.configure(with: image)
            }
            return cell
        } else if collectionView == self.categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            let category = presenter.categories[indexPath.item]
            cell.configure(with: category)
            return cell
        } else {
            fatalError("Unexpected collectionView")
        }
    }
    
    
}

//MARK: -UICollectionViewDelegateFlowLayout methods-
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.bannerCollectionView {
            
        } else if collectionView == self.categoryCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell
            cell?.nameLabel.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2)
            cell?.nameLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 13)
            cell?.nameLabel.layer.borderWidth = 0
            cell?.nameLabel.layer.cornerRadius = 20
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.bannerCollectionView {
            return CGSize(width: collectionView.frame.width, height: 112)
        } else if collectionView == self.categoryCollectionView {
            let width = collectionView.frame.width / 3 // Example: Adjust the number as per your design
            return CGSize(width: width, height: 40)
        } else {
            fatalError("Unexpected collectionView")
        }
    }
}

//MARK: -MainTable Data source methods-
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.foodItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FoodItemTableViewCell else {
            fatalError("Error while using dequeueReusableCell of tableView")
        }
        if let foodItem = presenter.foodItems?[indexPath.row] {
            cell.configure(with: foodItem)
        }
        return cell
    }
}
//MARK: -MainTable delegate methods-
extension MainViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hideBannerOffset: CGFloat = bannerCollectionView.frame.maxY
        if scrollView.contentOffset.y > hideBannerOffset {
            if !bannerCollectionView.isHidden {
                bannerCollectionView.isHidden = true
                categoryCollectionViewTopConstraint?.deactivate()
                categoryCollectionView.snp.makeConstraints { make in
                    self.categoryCollectionViewTopConstraint = make.top.equalTo(citySelectorButton.snp.bottom).offset(24).constraint
                }
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        } else {
            if bannerCollectionView.isHidden {
                bannerCollectionView.isHidden = false
                categoryCollectionViewTopConstraint?.deactivate()
                categoryCollectionView.snp.makeConstraints { make in
                    self.categoryCollectionViewTopConstraint = make.top.equalTo(bannerCollectionView.snp.bottom).offset(24).constraint
                }
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
}

extension MainViewController {
    @objc private func cityButtonTapped(_ sender: UIButton) {
        
    }
}
