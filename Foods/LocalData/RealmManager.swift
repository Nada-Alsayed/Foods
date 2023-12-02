//
//  RealmManager.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import RealmSwift

class RealmManager{
    
    //MARK: - Variables
    
    private var realmManager : Realm!
    static let sharedInstance = RealmManager()
    
    //MARK: - Init
    
    private init(){
        do{
            realmManager = try Realm()
        }catch{
            print("Realm CreationError \(error.localizedDescription)")
        }
    }
    
    //MARK: - Methods
    
    func insertToRealm(recipe : RecipeRealm){
        do{
            try realmManager.write{
                realmManager.add(recipe)
            }
        } catch {
            print("Error writing to Realm: \(error.localizedDescription)")
        }
    }
    
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
    
    func getAllRecipes() -> [RecipeRealm] {
        let recipes = realmManager.objects(RecipeRealm.self)
        return Array(recipes)
    }
    
    func getRecipe(withId id: String) -> RecipeRealm? {
        return realmManager.object(ofType: RecipeRealm.self, forPrimaryKey: id)
    }
    
    func doesRecipeExist(withId id: String) -> Bool {
        if realmManager.object(ofType: RecipeRealm.self, forPrimaryKey: id) != nil{
            return true
        } else {
            return false
        }
    }
    
}
