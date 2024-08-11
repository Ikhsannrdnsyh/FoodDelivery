//
//  HomeViewModel.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 04/07/24.
//

import Foundation

protocol HomeViewModelProtocol : AnyObject {
    func onViewDidLoad()
    var delegate : HomeViewModelDelegate? { get set }
    func getRestaurantList() -> [RestaurantListCellModel]
    func getCuisineList() -> [CuisineCarouselListCellModel]
    func onRestaurantListCellDidTaped(restaurantCellModel: RestaurantListCellModel)
    func onSetLocationButtonDidTapped()
    func onLocationPageDidPopped()
}


protocol HomeViewModelDelegate: AnyObject{
    func setupView()
    func reloadData()
    func navigateToRestaurantPage(restaurantData: RestaurantData)
    func navigateToLocationPage()
    func updateSetLocationButton(title: String)
}

class HomeViewModel : HomeViewModelProtocol{
    
    
    weak var delegate: (any HomeViewModelDelegate)?
    
    func onViewDidLoad() {
        delegate?.setupView()
        FetchRestaurantList()
        setupSetLocationButtonTitle()
    }
    
    private var restaurantCellModelList : [RestaurantListCellModel] = []
    private var cuisineCarouselList : [CuisineCarouselListCellModel] = []
    
    func getRestaurantList() -> [RestaurantListCellModel] {
        return restaurantCellModelList
    }
    
    func getCuisineList() -> [CuisineCarouselListCellModel] {
        return cuisineCarouselList
    }
    
    func onRestaurantListCellDidTaped(restaurantCellModel: RestaurantListCellModel) {
        if let restaurantData = RestaurantListFetcher.shared.restaurantData?.filter({ $0.name == restaurantCellModel.restaurantName }).first{
            delegate?.navigateToRestaurantPage(restaurantData: restaurantData)
        }
    }
    
    func onSetLocationButtonDidTapped() {
        delegate?.navigateToLocationPage()
    }
    
    func onLocationPageDidPopped() {
        setupSetLocationButtonTitle()
    }
    
}

private extension HomeViewModel{
    func FetchRestaurantList(){
        RestaurantListFetcher.shared.requestRestaurantList { [weak self] restaurantList, error in
            guard let self else { return }
            if let restaurantList, !restaurantList.isEmpty {
                self.restaurantCellModelList = RestaurantListFetcher.shared.convertRestaurantListToRestaurantListCell()
                self.cuisineCarouselList = RestaurantListFetcher.shared.convertCuisineList()
                
                self.delegate?.reloadData()
            }else if error != nil {
            
            }
        }
    }
    
    func setupSetLocationButtonTitle(){
        guard let savedLocation = SavedLocationService.shared.getSavedLocation() else {
            return
        }
        delegate?.updateSetLocationButton(title: savedLocation.locationName)
    }
    
}
