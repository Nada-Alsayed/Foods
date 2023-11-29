//
//  FavoriteVC.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit

class FavoriteVC: UIViewController {
    
    //MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFavorites: UILabel!
    
    //MARK: - Variables

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var recipes:[RecipeRealm] = []
    var viewModel = FavoriteViewModel()
    
    //MARK: - View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfiguration()
        recipes = viewModel.getSoredFavs()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipes = []
        recipes = viewModel.getSoredFavs()
        tableView.reloadData()
        if(recipes.count != 0){
           // print("kkkk")
            noFavorites.isHidden = true
        }else{
           // print("mmmmmm")
            noFavorites.isHidden = false
            tableView.isHidden = true
        }

    }
    
    //MARK: - Methods

    func setTableViewConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: foodCell.id, bundle: nil), forCellReuseIdentifier: foodCell.id)
    }
    
}

//MARK: - Extensions

extension FavoriteVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(136)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: foodCell.id, for: indexPath) as!foodCell
        cell.configureCell(recipeRealm: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AlertCreator().showAlertWithAction(title: "Delete alert!", titleAction: "Delete", titleNoAction: "No", message: "Are you sure you want to delete this recipe from your favorite recipes list?", viewController: self) {
                self.viewModel.deleteFavRecipe(recipe:self.recipes[indexPath.row])
                self.recipes.remove(at: indexPath.row)
                if(self.recipes.count != 0){
                    print("22")
                    self.noFavorites.isHidden = true
                }else{
                    print("55")
                    self.noFavorites.isHidden = false
                }
                self.tableView.reloadData()

            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.DETAILS_VC) as! DetailsVC
        vc.recipe = Reciepe().convertToRecipe(from: recipes[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
