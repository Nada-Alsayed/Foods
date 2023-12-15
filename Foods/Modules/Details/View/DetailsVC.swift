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
    
    var recipe : Reciepe?
    var ingredientsArray : [String]?
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
        showFavoriteImg()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
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
        dismiss(animated: true)
    }
    
    //MARK: - Methods

    func setTableViewConfiguration(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: igredientsCell.id, bundle: nil), forCellReuseIdentifier: igredientsCell.id)
    }
    
    func setPageWithData(){
        guard let recipe = recipe else {return}
        let readableTime = Helper.convertISO8601DurationToTime(duration:  recipe.time ?? "N/A")
        recipeName.text = recipe.name
        recipeHeadline.text = recipe.headline
        tiime.text = readableTime
        calories.text = recipe.calories
        carbs.text = recipe.carbos
        fats.text = recipe.fats
        proteins.text = recipe.proteins
        decriptionL.text = recipe.description
        recipeImg.kf.setImage(with:URL(string: recipe.image ?? ""))
        ingredientsArray = recipe.ingredients ?? []
    }
    
    func showFavoriteImg(){
        if viewModel.isRecipeExist(recipeID: recipe?.id ?? "0") == true
        {
            favoriteImg.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteImg.image  = UIImage(systemName: "heart")
        }
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
            showAlertWithAction(title: ConstantsStrings.ALERT, titleAction: ConstantsStrings.DELETE_BTN, titleNoAction: ConstantsStrings.NO_ACTION_BTN, message: ConstantsStrings.CONFIRM_DELETE_MESSAGE, viewController: self) {
                self.favoriteImg.image  = UIImage(systemName: "heart")
                self.viewModel.deleteFavRecipeById(id: self.recipe?.id ?? "")
            }

        }else{
            let realmObj = RecipeRealm().convertToRealmObject(from: self.recipe ?? Reciepe())
            favoriteImg.image = UIImage(systemName: "heart.fill")
            showToast(controller: self, message:ConstantsStrings.ADDED_TOAST, seconds: 2)
            viewModel.insertFavRecipe(recipe: realmObj)
        }
    }
    
}

//MARK: - Extensions

extension DetailsVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: igredientsCell.id, for: indexPath) as!igredientsCell
        cell.addCellConfiguration(label: ingredientsArray?[indexPath.row])
        return cell
    }
}

