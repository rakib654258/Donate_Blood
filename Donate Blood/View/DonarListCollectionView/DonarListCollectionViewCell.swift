//
//  DonarListCollectionViewCell.swift
//  Donate Blood
//
//  Created by RakiB on 2/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class DonarListCollectionViewCell: UICollectionViewCell {
    
    var number  = ""
    
    @IBOutlet weak var profileImgBG: CustomView!
    @IBOutlet weak var activeStatus: UIView!
    @IBOutlet weak var donarName: UILabel!

    @IBOutlet weak var DonarProfileImg: UIImageView!
    @IBOutlet weak var callBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgBG.layer.cornerRadius = profileImgBG.frame.height / 2
        DonarProfileImg.layer.cornerRadius = DonarProfileImg.frame.height / 2
        // Initialization code
    }
    
    @IBAction func callAction(_ sender: UIButton) {
        guard let number : NSURL = URL(string: "TEL://)" + "\(number)") as NSURL?
            else{return}
        UIApplication.shared.open(number as URL, options: [:], completionHandler: nil)
    }
    
}
