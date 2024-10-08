//
//  LocationCell.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 08/08/24.
//

import UIKit

class LocationCell: UITableViewCell {
    
    private lazy var locationLabel: UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0)
        
        return label
    }()
    
    private lazy var locationDetailsLabel: UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 2
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellModel(cellModel: LocationCellModel){
        locationLabel.text = cellModel.locationname
        locationDetailsLabel.text = cellModel.LocationDetails
    }
        
    
}

private extension LocationCell {
    func setupView(){
        contentView.addSubview(locationLabel)
        contentView.addSubview(locationDetailsLabel)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            
            locationDetailsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16.0),
            locationDetailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            locationDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            locationDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0)
        ])
    }
}
