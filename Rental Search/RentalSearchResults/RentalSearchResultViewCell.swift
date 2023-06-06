//
//  RentalSearchResultViewCell.swift
//  Rental Search
//
//  Created by arjuna on 06/06/23.
//

import UIKit

class RentalSearchResultViewCell: UITableViewCell {

    @IBOutlet weak var buildingNameLabel: UILabel!
    @IBOutlet weak var rentLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(viewModel: RentalSearchResultCellModel) {
        self.buildingNameLabel.text = viewModel.buildingName
        self.rentLabel.text = viewModel.rent
        self.addressLabel.text = viewModel.address
    }
}
