//
//  DetailsVC.swift
//  Foods
//
//  Created by MAC on 28/11/2023.
//

import UIKit

class DetailsVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var favoriteImg: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeHeadline: UILabel!
    @IBOutlet weak var tiime: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var decriptionL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ingredientHeightCon: NSLayoutConstraint!
    
    //MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    var recipe : Reciepe?
    lazy var viewModel = FavoriteViewModel()
    
    //MARK: - View Controller LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewConfiguration()
        addTapRecogniser()
        setPageWithData()
        setPageUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.addObserver(self, forKeyPath: "contentSize",options: .new , context: nil)
        
        if viewModel.isRecipeExist(recipeID: recipe?.id ?? "0") == true
        {
        //    print("mm")
            favoriteImg.image = UIImage(systemName: "heart.fill")
        }else{
        //    print("22")
            favoriteImg.image  = UIImage(systemName: "heart")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       // print("Hello")
        if keyPath == "contentSize" {
                if object as? UITableView == tableView {
                    if let newvalue = change?[.newKey] as? CGSize {
                        ingredientHeightCon.constant = newvalue.height
                    }
                }
            }
    }
    
    //MARK: - IBActions

    @IBAction func goBack(_ sender: Any) {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantsStrings.TABBAR_VC) as! CustomTabBar
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
    
    //MARK: - Methods

    func setTableViewConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: igredientsCell.id, bundle: nil), forCellReuseIdentifier: igredientsCell.id)
    }
    
    func setPageWithData(){
        guard let recipe = recipe else {return}
        recipeName.text = recipe.name
        recipeHeadline.text = recipe.headline
        tiime.text = recipe.time
        calories.text = recipe.calories
        carbs.text = recipe.carbos
        fats.text = recipe.fats
        proteins.text = recipe.proteins
        decriptionL.text = recipe.description
        recipeImg.kf.setImage(with:URL(string: recipe.image ?? ""))
    }
    
    func setPageUI(){
        recipeImg.layer.cornerRadius = recipeImg.layer.bounds.size.height / 2
    }
    
    func addTapRecogniser(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(addToFavorite))
        favoriteImg.isUserInteractionEnabled = true
        favoriteImg.addGestureRecognizer(tap)
    }
    
    @objc func addToFavorite(){
        if viewModel.isRecipeExist(recipeID: recipe?.id ?? "0") == true
        {
            AlertCreator().showAlertWithAction(title: "Delete alert!", titleAction: "Delete", titleNoAction: "No", message: "Are you sure you want to delete this recipe from your favorite recipes list?", viewController: self) {
                self.favoriteImg.image  = UIImage(systemName: "heart")
                self.viewModel.deleteFavRecipeById(id: self.recipe?.id ?? "")
            }

        }else{
            viewModel.insertFavRecipe(recipe: RecipeRealm().convertToRealmObject(from: self.recipe ?? Reciepe()))
            favoriteImg.image = UIImage(systemName: "heart.fill")
            AlertCreator().showToast(controller: self, message: "Recipe added to your favorites successfully", seconds: 2)
        }
    }
}

//MARK: - Extensions

extension DetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: igredientsCell.id, for: indexPath) as!igredientsCell
        
        cell.addCellConfiguration(label: recipe?.ingredients?[indexPath.row])
        
        return cell
    }
}

extension DetailsVC {
    func checkIfRecipeExist(){}
}
