//
//  CheckoutLocationView.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 06/08/24.
//

import UIKit

class CheckoutLocationView: UIView {
    private lazy var titleLabel: UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        label.text = "Delivery Location"
        
        return label
    }()
    
    private lazy var savedLocationLabel: UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "Ikhsan Home"
        
        return label
    }()
    
    private lazy var locationDetailsLabel: UILabel = {
        let label : UILabel = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.text = "Jalancagak, Kab. Subang"
        
        return label
    }()
    
    private lazy var setLocationButton : UIButton = {
        let button : UIButton = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "location.magnifyingglass"), for: .normal)
        button.setTitle("Your Location", for: .normal)
        button.tintColor = .systemGreen
        var config = UIButton.Configuration.borderedTinted()
        config.buttonSize = .medium
        config.cornerStyle = .capsule
        
        button.configuration = config
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CheckoutLocationView{
    func setupView(){
        addSubview(titleLabel)
        addSubview(savedLocationLabel)
        addSubview(locationDetailsLabel)
        addSubview(setLocationButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            
            savedLocationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            savedLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            
            locationDetailsLabel.topAnchor.constraint(equalTo: savedLocationLabel.bottomAnchor, constant: 4.0),
            locationDetailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            locationDetailsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            
            setLocationButton.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            setLocationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            setLocationButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16.0),
            
        ])
    }
}
