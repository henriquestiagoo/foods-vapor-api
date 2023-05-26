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
        let foods = routes.grouped("api", "foods")
        foods.get(use: index)
        foods.get(":foodId", use: find)
        foods.post(use: create)
        foods.put(use: update)
        foods.delete(":foodId", use: delete)
    }
    
    // GET Request /foods route
    func index(req: Request) async throws -> [Food] {
        try await Food.query(on: req.db).all()
    }
    
    // GET Request /foods/id route
    func find(req: Request) async throws -> Food {
        guard let food = try await Food.find(req.parameters.get("foodId"), on: req.db) else {
            throw Abort(.notFound)
        }
        return food
    }
    
    // POST Request /foods route
    func create(req: Request) async throws -> Food {
        let food = try req.content.decode(Food.self)
        try await food.save(on: req.db)
        return food
    }
    
    // PUT Request /foods routes
    func update(req: Request) async throws -> HTTPStatus {
        let food = try req.content.decode(Food.self)
        
        guard let foodFromDB = try await Food.find(food.id, on: req.db) else {
            throw Abort(.notFound)
        }
        foodFromDB.name = food.name
        foodFromDB.type = food.type
        foodFromDB.country = food.country
        try await foodFromDB.update(on: req.db)
        return .ok
    }
    
    // DELETE Request /foods/id route
    func delete(req: Request) async throws -> HTTPStatus {
        guard let food = try await Food.find(req.parameters.get("foodId"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await food.delete(on: req.db)
        return .noContent
    }
    
}
