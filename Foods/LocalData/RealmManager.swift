//
//  RealmManager.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import RealmSwift

class RealmManager{
    private var realmManager : Realm!
    
    static let sharedInstance = RealmManager()
    
    private init(){
        do{
            realmManager = try Realm()
        }catch{
            print("Realm CreationError \(error.localizedDescription)")
        }
    }
    
    func insertToRealm(recipe : RecipeRealm){
        do{
            try realmManager.write{
                realmManager.add(recipe)
            }
        } catch {
            print("Error writing to Realm: \(error.localizedDescription)")
        }
    }
    
    // Delete data from Realm
    func deleteFromRealm(recipe: RecipeRealm) {
        do {
            try realmManager.write {
                realmManager.delete(recipe)
            }
        } catch {
            print("Error deleting from Realm: \(error.localizedDescription)")
        }
    }

    func deleteFromRealmById(id:String){
        guard let recipe = realmManager.object(ofType: RecipeRealm.self, forPrimaryKey: id) else { return  }
        deleteFromRealm(recipe: recipe)
    }
    
    // Get all data from Realm
    func getAllRecipes() -> [RecipeRealm] {
        let recipes = realmManager.objects(RecipeRealm.self)
        return Array(recipes)
    }
    
    // Get a RecipeRealm object by its ID
   func getRecipe(withId id: String) -> RecipeRealm? {
       return realmManager.object(ofType: RecipeRealm.self, forPrimaryKey: id)
   }
    
    // Check if a RecipeRealm object with a specific primary key exists
    func doesRecipeExist(withId id: String) -> Bool {
        if realmManager.object(ofType: RecipeRealm.self, forPrimaryKey: id) != nil {
            return true
        } else {
            return false
        }
    }
    
}
