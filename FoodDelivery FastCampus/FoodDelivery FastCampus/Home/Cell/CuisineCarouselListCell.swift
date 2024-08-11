//
//  CuisineCarouselListCell.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 05/07/24.
//

import UIKit

class CuisineCarouselListCell: UICollectionViewCell {
    private lazy var collectionView : UICollectionView = {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 32.0
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(CuisineListCell.self, forCellWithReuseIdentifier: "cuisineList")
    
        return collectionView
    }()
    
    private var listCellModel: [CuisineCarouselListCellModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getHeight() -> CGFloat{
        return 128.0
    }
    
    func setupDataModel(dataModel: [CuisineCarouselListCellModel]){
        listCellModel = dataModel
        collectionView.reloadData()
    }
}

private extension CuisineCarouselListCell{
    func setupView(){
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
}

extension CuisineCarouselListCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCellModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cuisineList", for: indexPath) as? CuisineListCell else{
            return UICollectionViewCell()
        }
        
        cell.setupCellData(cellModel: listCellModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0, height: 112.0)
    }
}

class CuisineListCell: UICollectionViewCell{
    private lazy var cuisineImageView : UIImageView = {
        let imageView : UIImageView = UIImageView(frame: .zero)
        imageView.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        imageView.layer.cornerRadius = 32.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var cuisineLabelView : UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellData(cellModel: CuisineCarouselListCellModel){
        if let cuisineImageURL = cellModel.cuisineImageURL,
           let imageURL : URL = URL(string: cuisineImageURL){
            cuisineImageView.load(url: imageURL)
        }
        cuisineLabelView.text = cellModel.cuisineName
    }
}

private extension CuisineListCell{
    func setupView(){
        contentView.addSubview(cuisineImageView)
        contentView.addSubview(cuisineLabelView)
        
        NSLayoutConstraint.activate([
            cuisineImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cuisineImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            cuisineLabelView.topAnchor.constraint(equalTo: cuisineImageView.bottomAnchor, constant: 8.0),
            cuisineLabelView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cuisineLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        
        ])
    }
}
