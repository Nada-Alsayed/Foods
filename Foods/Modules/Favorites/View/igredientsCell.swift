//
//  igredientsCell.swift
//  Foods
//
//  Created by MAC on 28/11/2023.
//

import UIKit

class igredientsCell: UITableViewCell {

    @IBOutlet weak var Ingredient: UILabel!
    static let id = String(describing: igredientsCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func addCellConfiguration(label : String?){
        Ingredient.text = label ?? "N/A"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
