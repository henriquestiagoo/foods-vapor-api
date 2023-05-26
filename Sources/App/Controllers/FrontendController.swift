//
//  FrontendController.swift
//  
//
//  Created by Tiago Henriques on 25/05/2023.
//

import Vapor

struct HomeContext: Encodable {
    let foods: [Food]
}

struct FrontendController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: get)
    }
    
    func get(req: Request) async throws -> View {
        return try await req.view.render("Home")
    }
}
