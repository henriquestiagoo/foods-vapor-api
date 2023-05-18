//
//  FoodController.swift
//  
//
//  Created by Tiago Henriques on 18/05/2023.
//

import Fluent
import Vapor

struct FoodController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let foods = routes.grouped("foods")
        foods.get(use: index)
        foods.post(use: create)
        foods.group(":foodId") { food in
            food.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> [Food] {
        try await Food.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Food {
        let food = try req.content.decode(Food.self)
        try await food.save(on: req.db)
        return food
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let food = try await Food.find(req.parameters.get("foodId"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await food.delete(on: req.db)
        return .noContent
    }
    
}
