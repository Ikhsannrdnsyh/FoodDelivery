//
//  UIImageView+Extension.swift
//  FoodDelivery FastCampus
//
//  Created by Mochamad Ikhsan Nurdiansyah on 05/07/24.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString,UIImage>()
    
    private init(){
        ImageCache.shared.countLimit = 100 // max number of item in cache
        ImageCache.shared.totalCostLimit =  1024 * 1024 * 100 // Max 100 MB
    }
}

extension UIImageView{
    func load(url: URL, placeholder: UIImage? = nil){
        // set the placeHolder image if any
        self.image = placeholder
        
        //check if the image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString){
            self.image = cachedImage
            return
        }
        
        //Download image Asychronus
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Failed to load Image from url : \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data, scale: 0.05) else {
                print("Failed to load image from data")
                return
            }
            
            //cache the image
            ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString, cost: data.count)
            
            //set the image on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}

//extension UIImageView{
//    
//    /// Load URL for UIImageView
//    /// - Parameter url: url to be loaded
//    func load(url : URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data){
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
