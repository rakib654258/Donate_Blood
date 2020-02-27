//
//  FAQTableViewCell.swift
//  Donate Blood
//
//  Created by RakiB on 18/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var qsnLbl: UILabel!
    @IBOutlet weak var ansLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
