//
//  FlickrHelper.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import UIKit
import Foundation

class FlickrHelper: NSObject {
    
    //Generate url vy coming parameters
    class func URLForSearchString(searchString: String, page: Int) -> String {
        
        let apiKEY: String = "4e8549cecc409035f95db4e57f415259"
        let search: String = searchString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let url = "https://api.flickr.com/services/rest?api_key=\(apiKEY)&method=flickr.photos.search&tags=\(search)&format=json&nojsoncallback=true&extras=media&extras=url_sq&extras=url_m&per_page=20&page=\(page)"
        
        return url
        
    }
    
    
    
    
    
    
}
