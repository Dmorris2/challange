//
//  GuideTableViewCell.swift
//  ChallengeApp
//
//  Created by Daven Morris on 1/25/22.
//

import UIKit

class GuideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func setModel(_ model: GuideInfo) {
        nameLabel.text = model.name
        //startLabel.text = model.startDate
        dateLabel.text = "Dates: \(model.startDate) - \(model.endDate)"
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
    }
}
