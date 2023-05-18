//
//  CreateFood.swift
//  
//
//  Created by Tiago Henriques on 18/05/2023.
//

import Fluent

struct CreateFood: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("foods")
            .id()
            .field("name", .string, .required)
            .field("type", .string, .required)
            .field("country", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("foods").delete()
    }
}
