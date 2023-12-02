//
//  igredientsCell.swift
//  Foods
//
//  Created by MAC on 28/11/2023.
//

import UIKit

class igredientsCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet weak var Ingredient: UILabel!
    
    //MARK: - Variables

    static let id = String(describing: igredientsCell.self)
    
    //MARK: - Methods

    func addCellConfiguration(label : String?){
        Ingredient.text = label ?? "N/A"
    }
}
