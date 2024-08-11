//
//  CheckoutViewModel.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 06/08/24.
//

import Foundation

protocol CheckoutViewModelProtocol: AnyObject{
    func onViewDidLoad()
    var delegate: CheckoutViewModelDelegate? { get set }
    func onEditButtonDidTapped(orderIndex: Int, menuIndex: Int)
    func onDecreaseButtonDidTapped(orderIndex: Int, menuIndex: Int, qty: Int)
    func onIncreaseButtonDidTapped(orderIndex: Int, menuIndex: Int, qty: Int)
    func onMenuDetailDismissModal()
    //func onSetLocationDidTaped()
    //func onSLocationPageDidPopped()
    func onPayButtonDidTapped()
}

protocol CheckoutViewModelDelegate: AnyObject{
    func setupView()
    func updateOrderListToView(menuOrderList: [MenuOrder], index: Int)
    func setupTotalPrice(totalPriceString: String)
    func presentMenuDetailModally(with menuOrder: MenuOrder)
    func resetStackView()
    //func navigateToSetLocationPage()
    //func updateLocationDetails(locationName: String, locationDetails: String
    func popToRootViewController()
    
}

class CheckoutViewModel: CheckoutViewModelProtocol{
    
    let restaurantData: RestaurantData
    
    init(restaurantData: RestaurantData) {
        self.restaurantData = restaurantData
    }
    
    weak var delegate: CheckoutViewModelDelegate?
    
    func onViewDidLoad() {
        delegate?.setupView()
        setupMenuOrderList()
        setupTotalPrice()
    }
    func onEditButtonDidTapped(orderIndex: Int, menuIndex: Int) {
        let orderList: [MenuOrder] = MenuCartService.shared.getOrderList(for: restaurantData.menus[menuIndex])
        delegate?.presentMenuDetailModally(with: orderList[orderIndex])
    }
    
    func onDecreaseButtonDidTapped(orderIndex: Int, menuIndex: Int, qty: Int) {
        let orderList: [MenuOrder] = MenuCartService.shared.getOrderList(for: restaurantData.menus[menuIndex])
        let newOrder: MenuOrder = orderList[orderIndex]
        newOrder.qty = qty
        MenuCartService.shared.updateOrder(menuOrder: orderList[orderIndex])
        //update total price
        setupTotalPrice()
    }
    
    func onIncreaseButtonDidTapped(orderIndex: Int, menuIndex: Int, qty: Int) {
        let orderList: [MenuOrder] = MenuCartService.shared.getOrderList(for: restaurantData.menus[menuIndex])
        let newOrder: MenuOrder = orderList[orderIndex]
        newOrder.qty = qty
        MenuCartService.shared.updateOrder(menuOrder: orderList[orderIndex])
        //update total price
        setupTotalPrice()
    }
    
    func onMenuDetailDismissModal() {
        // update total price dan order detais
        setupTotalPrice()
        //car 2: update semua order
        setupMenuOrderList()
    }
    
//    func onSetLocationButtonDidTapped(){
//       delegate?.navigate toSetLocationPage()
//    }
    
//    func onSetLocationButtonDidTapped(){
//        delegate?.navigate toSetLocationPage()
//    }
    
    func onPayButtonDidTapped() {
        //save cart data ke local storage
        guard let cartData: CartData = MenuCartService.shared.cartData else {
            return
        }
        SavedCartService.shared.saveCartData(cartData)
        //pop view COntroller ke root viewController
        delegate?.popToRootViewController()
    }
}

private extension CheckoutViewModel{
    func resetMenuOrderList(){
        delegate?.resetStackView()
    }
    func setupMenuOrderList(){
        resetMenuOrderList()
        for (index, menu) in restaurantData.menus.enumerated(){
            let orderList: [MenuOrder] = MenuCartService.shared.getOrderList(for: menu)
            //update di vc dan append tiap view di scrollview
            delegate?.updateOrderListToView(menuOrderList: orderList, index: index)
        }
    }
    
    func setupTotalPrice(){
        let totalPrice: String = "Rp. \(MenuCartService.shared.getTotalPrice())"
        delegate?.setupTotalPrice(totalPriceString: totalPrice)
    }
}
