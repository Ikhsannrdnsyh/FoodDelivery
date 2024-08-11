//
//  RestaurantData.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 06/07/24.
//

import Foundation

struct RestaurantData: Codable{
    let name: String
    let cuisine: String
    let cuisineImageURL: String
    let imageURL: String
    let menus: [MenuData]
    let location: RestaurantLocation
    
}

struct RestaurantLocation: Codable{
    let city: String
    let lat: Float
    let long: Float
}


struct MenuData: Codable {
    let description: String
    let imageURL: String
    let name: String
    let price: Float
}
