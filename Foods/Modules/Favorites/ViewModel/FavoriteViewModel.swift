//
//  FavoriteViewModel.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation

class FavoriteViewModel{
    
    //MARK: - Variables

    var realmInstance : RealmManager!
    var bindResultToView : (()->()) = {}
    var favoritesArray:[RecipeRealm]!
    
    //MARK: - Init

    init( realmInstance: RealmManager = RealmManager.sharedInstance) {
        self.realmInstance = realmInstance
    }
    
    //MARK: - Methods

    func getSoredFavs() -> [RecipeRealm]{
        return realmInstance.getAllRecipes()
    }
    
    func deleteFavRecipe(recipe:RecipeRealm){
        realmInstance.deleteFromRealm(recipe: recipe)
    }
    
    func deleteFavRecipeById(id:String){
        realmInstance.deleteFromRealmById(id: id)
    }
    
    func insertFavRecipe(recipe:RecipeRealm){
        realmInstance.insertToRealm(recipe: recipe)
    }
    
    func isRecipeExist(recipeID:String)->Bool{
        return realmInstance.doesRecipeExist(withId: recipeID)
    }
}
