//
//  MenuOrder.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 26/07/24.
//

import Foundation

class MenuOrder : Codable{
    var menu : MenuData
    var qty : Int
    var notes : String?
    
    init(menu: MenuData, qty: Int, notes: String? = nil) {
        self.menu = menu
        self.qty = qty
        self.notes = notes
    }
}
