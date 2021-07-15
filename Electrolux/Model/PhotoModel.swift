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
    var id = UUID() //It added because while getting items, some items have the same id number(It estimated during some errors). It is my own solution
    var picId: String?
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
        //do readable code with swift syntax
        case picId = "id", owner, secret, server, farm, title, isPublic = "ispublic", isFriend = "isfriend", isFamily = "isfamily", urlM = "url_m", heightM = "height_m", widthM = "width_m"
    }
}
