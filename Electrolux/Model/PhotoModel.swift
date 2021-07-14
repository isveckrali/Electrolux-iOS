//
//  ImageModel.swift
//  Electrolux
//
//  Created by Mehmet Can Seyhan on 2021-07-11.
//

import Foundation

struct PhotoModel: Decodable {
    var photos: Photos?
    
}

struct Photos: Decodable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: Int?
    var photo: [Photo]
    var stat: String?
    
}

struct Photo: Decodable, Identifiable, Equatable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var isPublic: Int?
    var isFriend: Int?
    var isFamily: Int?
    var urlM: String?
    var heightM: Int?
    var widthM: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, isPublic = "ispublic", isFriend = "isfriend", isFamily = "isfamily", urlM = "url_m", heightM = "height_m", widthM = "width_m"
    }
}
