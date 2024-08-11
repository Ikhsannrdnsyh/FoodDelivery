//
//  SavedLocationService.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 10/08/24.
//

import Foundation

struct SavedLocation{
    let latitude: Double
    let longitude: Double
    let locationName: String
    let locationDetails: String
}

class SavedLocationService{
    static let shared: SavedLocationService = SavedLocationService()
    
    func getSavedLocation() -> SavedLocation? {
        let savedLat = UserDefaults.standard.double(forKey: "savedLatitude")
        let savedLong = UserDefaults.standard.double(forKey: "savedLongitude")
        let savedLocationName = UserDefaults.standard.string(forKey: "locationName")
        let savedLocationsDetails = UserDefaults.standard.string(forKey: "locationDetails")
        
        guard let savedLocationName, 
                let savedLocationsDetails,
                savedLat != 0.0 && savedLong != 0.0 else { return nil }
        
        let savedLocation: SavedLocation = SavedLocation(latitude: savedLat, longitude: savedLong, locationName: savedLocationName, locationDetails: savedLocationsDetails)
        
        return savedLocation
    }
    func saveLocation(savedLocation: SavedLocation){
        UserDefaults.standard.set(savedLocation.latitude, forKey: "savedLatitude")
        UserDefaults.standard.set(savedLocation.longitude, forKey: "savedLongitude")
        UserDefaults.standard.set(savedLocation.locationName, forKey: "locationName")
        UserDefaults.standard.set(savedLocation.locationDetails, forKey: "locationDetails")
    }
}
