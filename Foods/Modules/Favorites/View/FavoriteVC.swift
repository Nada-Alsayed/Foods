//
//  FavoriteVC.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noFavorites: UILabel!
   
    var recipes:[RecipeRealm] = []
    var viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfiguration()
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
        
       // cell.configureCell(recipe: recipes[indexPath.row])
        return cell
    }
    
    
}
