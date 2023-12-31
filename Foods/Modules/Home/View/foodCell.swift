//
//  foodCell.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit
import Kingfisher

class foodCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRate: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Variables
    
    static let id = String(describing: foodCell.self)
    let color: UIColor = UIColor(red: 240.0/255.0, green: 141.0/255.0, blue: 2.0/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }
    
    //MARK: - Methods
    
    func setCellUI(){
        view.addBorder(to: .left, color: color, thickness: 2.0)
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = color.cgColor
        recipeImg.layer.cornerRadius = recipeImg.layer.frame.size.height / 2
    }
    func configureCell(recipe:Reciepe){
        let readableTime = Helper.convertISO8601DurationToTime(duration:  recipe.time ?? "N/A")
        recipeImg.kf.setImage(with:URL(string: recipe.image ?? ""))
        recipeName.text = recipe.name
        recipeTime.text = readableTime
        recipeRate.text = "\(recipe.rating ?? 0.0) "
    }
    
    func configureCell(recipeRealm:RecipeRealm){
        let readableTime = Helper.convertISO8601DurationToTime(duration:  recipeRealm.time ?? "N/A")
        recipeImg.kf.setImage(with:URL(string: recipeRealm.image ?? ""))
        recipeName.text = recipeRealm.name
        recipeTime.text = readableTime
        recipeRate.text = "\(recipeRealm.rating ) "
    }
}
