//
//  SearchViewModel.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 06/07/24.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    func onViewDidLoad()
    var delegate: SearchViewModelDelegate? { get set }
    func getFilteredRestaurantList() -> [RestaurantListCellModel]
    func getFilteredCuisineList() -> [CuisineCarouselListCellModel]
    func onTextFieldValueDidChanged(text: String)
    func onRestaurantListCellDidTaped(restaurantCellModel: RestaurantListCellModel)
    
}

protocol SearchViewModelDelegate: AnyObject{
    func setupView()
    func reloadData()
    func navigateToRestaurantPage(restaurantData: RestaurantData)
}

class SearchViewModel : SearchViewModelProtocol{
    weak var delegate: SearchViewModelDelegate?
    
    private var restaurantList : [RestaurantListCellModel] {
        return RestaurantListFetcher.shared.convertRestaurantListToRestaurantListCell()
    }
    
    private var cuisineList : [CuisineCarouselListCellModel] {
        return RestaurantListFetcher.shared.convertCuisineList()
    }
    
    private var filteredRestaurantList: [RestaurantListCellModel] = []
    private var filteredCuisineList: [CuisineCarouselListCellModel] = []
    
    
    private var restaurantData: [RestaurantData]? {
        return RestaurantListFetcher.shared.restaurantData
    }
    
    func onViewDidLoad() {
        delegate?.setupView()
        
    }
    func getFilteredRestaurantList() -> [RestaurantListCellModel] {
        return filteredRestaurantList
    }
    
    func getFilteredCuisineList() -> [CuisineCarouselListCellModel] {
        return filteredCuisineList
    }
    
    func onTextFieldValueDidChanged(text: String) {
        if text.isEmpty {
            resetFilteredList()
        }else{
            //logic search
            filterRestaurantList(text: text)
            filterCuisineList(text: text)
            delegate?.reloadData()
        }
    }
    func onRestaurantListCellDidTaped(restaurantCellModel: RestaurantListCellModel) {
        if let restaurantData = RestaurantListFetcher.shared.restaurantData?.filter({ $0.name == restaurantCellModel.restaurantName }).first{
            delegate?.navigateToRestaurantPage(restaurantData: restaurantData)
        }
    }
}

private extension SearchViewModel{
    func resetFilteredList(){
        filteredCuisineList = []
        filteredRestaurantList = []
        delegate?.reloadData()
    }
    
    func filterRestaurantList(text: String){
        let newFilteredRestaurantList = restaurantList.filter({ $0.cuisineName.lowercased().contains(text.lowercased()) ||
            $0.restaurantName.lowercased().contains(text.lowercased())})
        filteredRestaurantList = newFilteredRestaurantList
    }
    func filterCuisineList(text: String){
        let newFilteredCuisineList = cuisineList.filter({ $0.cuisineName.lowercased().contains(text.lowercased())})
        filteredCuisineList = newFilteredCuisineList
    }
}
