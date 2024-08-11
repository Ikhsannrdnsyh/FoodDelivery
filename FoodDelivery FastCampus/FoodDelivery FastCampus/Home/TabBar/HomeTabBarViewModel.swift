//
//  HomeTabBarViewModel.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 04/07/24.
//

import Foundation

protocol HomeTabBarViewModelProtocol: AnyObject{
    func onViewWillAppear()
    var delegate : HomeTabBarViewModelDelegate? { get set }
}

protocol HomeTabBarViewModelDelegate: AnyObject{
    func setupView()
}

class HomeTabBarViewModel : HomeTabBarViewModelProtocol {
    weak var delegate: (any HomeTabBarViewModelDelegate)?
    
    func onViewWillAppear() {
        delegate?.setupView()
    }
    
    
    
}
