import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get("welcome") { req async in
        "Welcome to the Foods API 🍏🍕🍦!"
    }

    app.get("hello") { req async -> String in
        "Hello from the Foods API 🍏🍕🍦!"
    }

    try app.register(collection: FoodController())
    try app.register(collection: HomeController())
}
