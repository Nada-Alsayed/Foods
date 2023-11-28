//
//  RealmModel.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import RealmSwift

class RecipeRealm: Object {
    @objc dynamic var id: String?
    @objc dynamic var fats: String?
    @objc dynamic var name: String?
    @objc dynamic var time: String?
    @objc dynamic var image: String?
    var weeks: List<String>?
    @objc dynamic var carbos: String?
    @objc dynamic var fibers: String?
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var country: String?
    @objc dynamic var ratings: Int = 0
    @objc dynamic var calories: String?
    @objc dynamic var headline: String?
    var keywords: List<String>?
    var products: List<String>?
    @objc dynamic var proteins: String?
    @objc dynamic var favorites: Int = 0
    @objc dynamic var difficulty: Int = 0
    @objc dynamic var recipeDescription: String?
    @objc dynamic var highlighted: Bool = false
    var ingredients: List<String>?
    var deliverableIngredients: List<String>?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
