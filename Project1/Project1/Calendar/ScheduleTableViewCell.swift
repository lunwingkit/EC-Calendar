//
//  CustomTableViewCell.swift
//  Project1
//
//  Created by LUN WING KIT on 26/3/2019.
//  Copyright © 2019 LUN WING KIT. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell, UITextFieldDelegate {

    //@IBOutlet weak var textField: UITextFiled!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
