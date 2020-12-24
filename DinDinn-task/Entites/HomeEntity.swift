//
//  HomeEntity.swift
//  DinDinn-task
//
//  Created by Ragaie Alfy on 11/20/20.
//

import Foundation
import ObjectMapper

struct HomeEntity: Mappable {
    var status: String?
    var types: [String]?
    var items: [OrderEntity]?
    var banners : [String]?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        status     <- map["status"]
        types     <- map["types"]
        items     <- map["items"]
        banners   <- map["banners"]


    }
}

struct OrderEntity: Mappable {
    var id : Int?

    var name: String?
    var imageUrl: String?
    var weight: String?
    var desc: String?
    var price: Int?
    var size: String?
    var type: String?
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id     <- map["id"]

        name     <- map["name"]
        imageUrl     <- map["imageUrl"]
        weight     <- map["weight"]
        desc     <- map["desc"]
        price     <- map["price"]
        size     <- map["size"]
        type     <- map["type"]
    }
}


