//
//  RestaurantListCell.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 05/07/24.
//

import UIKit

class RestaurantListCell: UICollectionViewCell {
    
    private lazy var restaurntImageView : UIImageView = {
        let imageView : UIImageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var retaurantLabel : UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        
        return label
    }()
    
    private lazy var cuisineLabel : UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .thin)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getHeight() -> CGFloat{
        return 290.0
    }
    
    func setupData(cellModel : RestaurantListCellModel){
        //1. set func load Data dari Url ke UIimage
        //2. set UIimage hasil load ke restaurant View
        if let restaurantImageURL : String = cellModel.restaurantImageUrl,
           let ImageURL : URL = URL(string: restaurantImageURL) {
            restaurntImageView.load(url: ImageURL)
        }
        
        retaurantLabel.text = cellModel.restaurantName
        cuisineLabel.text = cellModel.cuisineName
    }
    
}


private extension RestaurantListCell {
    func setupView(){
        contentView.addSubview(restaurntImageView)
        contentView.addSubview(retaurantLabel)
        contentView.addSubview(cuisineLabel)
        
        
        NSLayoutConstraint.activate([
            restaurntImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            restaurntImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            restaurntImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            restaurntImageView.heightAnchor.constraint(equalToConstant: 200.0),
            
            retaurantLabel.topAnchor.constraint(equalTo: restaurntImageView.bottomAnchor, constant: 16.0),
            retaurantLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            retaurantLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            cuisineLabel.topAnchor.constraint(equalTo: retaurantLabel.bottomAnchor, constant: 16.0),
            cuisineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            cuisineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            cuisineLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        ])
        
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 7.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
}
