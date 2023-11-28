//
//  foodCell.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import UIKit
import Kingfisher

class foodCell: UITableViewCell {

    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeRate: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    static let id = String(describing: foodCell.self)
    
    let color: UIColor = UIColor(red: 240.0/255.0, green: 141.0/255.0, blue: 2.0/255.0, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellUI(){
        view.addBorder(to: .left, color: color, thickness: 2.0)
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = color.cgColor
        recipeImg.layer.cornerRadius = recipeImg.layer.frame.size.height / 2
    }
    func configureCell(recipe:Reciepe){
        
        recipeImg.kf.setImage(with:URL(string: recipe.image ?? ""))
        recipeName.text = recipe.name
        recipeTime.text = recipe.time
        recipeRate.text = "\(recipe.rating ?? 0.0) "
    }
}
