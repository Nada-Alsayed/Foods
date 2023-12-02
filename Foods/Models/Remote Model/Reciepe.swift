//
//  Reciepe.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import RealmSwift

struct Reciepe: Codable {
    var id, fats, name, time: String?
    var image: String?
    var weeks: [String]?
    var carbos, fibers: String?
    var rating: Double?
    var country: String?
    var ratings: Int?
    var calories, headline: String?
    var keywords, products: [String]?
    var proteins: String?
    var favorites, difficulty: Int?
    var description: String?
    var highlighted: Bool?
    var ingredients: [String]?
    var deliverableIngredients: [String]?

    enum CodingKeys: String, CodingKey {
        case id, fats, name, time, image, weeks, carbos, fibers, rating, country, ratings, calories, headline, keywords, products, proteins, favorites, difficulty, description, highlighted, ingredients
        case deliverableIngredients = "deliverable_ingredients"
     
    }
    
     func convertToRecipe(from realmRecipe: RecipeRealm) -> Reciepe {
        var recipe = Reciepe()

        recipe.id = realmRecipe.id
        recipe.fats = realmRecipe.fats
        recipe.name = realmRecipe.name
        recipe.time = realmRecipe.time
        recipe.image = realmRecipe.image
        recipe.weeks = realmRecipe.weeks?.toArray()
        recipe.carbos = realmRecipe.carbos
        recipe.fibers = realmRecipe.fibers
        recipe.rating = realmRecipe.rating
        recipe.country = realmRecipe.country
        recipe.ratings = realmRecipe.ratings
        recipe.calories = realmRecipe.calories
        recipe.headline = realmRecipe.headline
        recipe.keywords = realmRecipe.keywords?.toArray()
        recipe.products = realmRecipe.products?.toArray()
        recipe.proteins = realmRecipe.proteins
        recipe.favorites = realmRecipe.favorites
        recipe.difficulty = realmRecipe.difficulty
        recipe.description = realmRecipe.recipeDescription
        recipe.highlighted = realmRecipe.highlighted
        recipe.ingredients = realmRecipe.ingredients?.toArray()
        recipe.deliverableIngredients = realmRecipe.deliverableIngredients?.toArray()

        return recipe
    }

    init() {
            id = nil
            fats = nil
            name = nil
            time = nil
            image = nil
            weeks = nil
            carbos = nil
            fibers = nil
            rating = nil
            country = nil
            ratings = nil
            calories = nil
            headline = nil
            keywords = nil
            products = nil
            proteins = nil
            favorites = nil
            difficulty = nil
            description = nil
            highlighted = nil
            ingredients = nil
            deliverableIngredients = nil
        }
}
extension List {
    func toArray() -> [Element] {
        return self.compactMap { $0 }
    }
}
