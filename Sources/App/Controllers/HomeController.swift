//
//  HomeController.swift
//  
//
//  Created by Tiago Henriques on 25/05/2023.
//

import Vapor

struct HomeContext: Encodable {
    let foods: [Food]
}

struct HomeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: get)
    }
    
    func get(req: Request) async throws -> View {
        let foods = try await Food.query(on: req.db)
            .sort(\.$country)
            .all()
        return try await req.view.render("Home", HomeContext(foods: foods))
    }
}
