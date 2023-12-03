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
            noFavorites.isHidden = true
        }else{
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
            showAlertWithAction(title: ConstantsStrings.ALERT, titleAction: ConstantsStrings.DELETE_BTN, titleNoAction: ConstantsStrings.NO_ACTION_BTN, message: ConstantsStrings.CONFIRM_DELETE_MESSAGE, viewController: self) {
                self.viewModel.deleteFavRecipe(recipe:self.recipes[indexPath.row])
                self.recipes.remove(at: indexPath.row)
                if(self.recipes.count != 0){
                    self.noFavorites.isHidden = true
                }else{
                    self.noFavorites.isHidden = false
                }
                self.tableView.reloadData()

            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.DETAILS_VC) as! DetailsVC
        vc.recipe = Reciepe().convertToRecipe(from: recipes[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
