//
//  TableViewCell.swift
//  TFTApi
//
//  Created by Andres Perez Martinez on 05/09/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellChampion0Image: UIImageView!
    @IBOutlet weak var cellPlacementLabel: UILabel!
    @IBOutlet weak var cellDamageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellChampion0Image.layer.cornerRadius = 24
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
