//
//  DailyRecordCell.swift
//  The_Reminder
//
//  Created by Ashok on 12/01/24.
//

import UIKit

class DailyRecordCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
