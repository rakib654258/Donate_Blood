//
//  ImageCache.swift
//  Donate Blood
//
//  Created by RakiB on 5/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    func loadImageUsingCacheWithUrlString(urlString: String){
        // check cache for image first
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cacheImage
            return
        }
        
        // otherwise new download
        guard let url = URL(string: urlString) else{return}
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            guard let data = data else{return}
            guard let downloadedImage = UIImage(data: data) else{return}
            imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }).resume()
    }
}
