//
//  RealmModel.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import RealmSwift

class RecipeRealm: Object {
    
    //MARK: - Variables
    
    @objc dynamic var id: String?
    @objc dynamic var fats: String?
    @objc dynamic var name: String?
    @objc dynamic var time: String?
    @objc dynamic var image: String?
    var weeks = List<String>()
    @objc dynamic var carbos: String?
    @objc dynamic var fibers: String?
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var country: String?
    @objc dynamic var ratings: Int = 0
    @objc dynamic var calories: String?
    @objc dynamic var headline: String?
    var keywords = List<String>()
    var products = List<String>()
    @objc dynamic var proteins: String?
    @objc dynamic var favorites: Int = 0
    @objc dynamic var difficulty: Int = 0
    @objc dynamic var recipeDescription: String?
    @objc dynamic var highlighted: Bool = false
    var ingredients = List<String>()
    var deliverableIngredients = List<String>()
    
    //MARK: - Methods
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func convertToRealmObject(from recipe: Reciepe) -> RecipeRealm {
        let realmRecipe = RecipeRealm()
        realmRecipe.id = recipe.id
        realmRecipe.fats = recipe.fats
        realmRecipe.name = recipe.name
        realmRecipe.time = recipe.time
        realmRecipe.image = recipe.image
        realmRecipe.weeks.append(objectsIn: recipe.weeks ?? [])
        realmRecipe.carbos = recipe.carbos
        realmRecipe.fibers = recipe.fibers
        realmRecipe.rating = recipe.rating ?? 0.0
        realmRecipe.country = recipe.country
        realmRecipe.ratings = recipe.ratings ?? 0
        realmRecipe.calories = recipe.calories
        realmRecipe.headline = recipe.headline
        realmRecipe.keywords.append(objectsIn: recipe.keywords ?? [])
        realmRecipe.products.append(objectsIn: recipe.products ?? [])
        realmRecipe.proteins = recipe.proteins
        realmRecipe.favorites = recipe.favorites ?? 0
        realmRecipe.difficulty = recipe.difficulty ?? 0
        realmRecipe.recipeDescription = recipe.description
        realmRecipe.highlighted = recipe.highlighted ?? false
        realmRecipe.deliverableIngredients.append(objectsIn:recipe.deliverableIngredients ?? [])
        
        if let ingredients = recipe.ingredients {
            realmRecipe.ingredients.append(objectsIn: ingredients)
          //  print("oooo\(realmRecipe.ingredients.toArray())")
            
        } else {
          //  print("ooooIngredients is nil")
        }
       // print("saved obj \(realmRecipe.ingredients.toArray())")
      return realmRecipe
    }
}
