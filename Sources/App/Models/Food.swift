//
//  Food.swift
//  
//
//  Created by Tiago Henriques on 18/05/2023.
//

import Fluent
import Vapor

enum FoodType: String, Codable {
    case food
    case drink
    case dessert
}

final class Food: Model, Content {
    static let schema: String = "foods"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Enum(key: "type")
    var type: FoodType
    
    @Field(key: "country")
    var country: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, type: FoodType, country: String) {
        self.id = id
        self.name = name
        self.type = type
        self.country = country
    }
}
