//
//  ProfileVC.swift
//  Donate Blood
//
//  Created by RakiB on 2/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileBGView: CustomView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    var proName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(proName)
        // Do any additional setup after loading the view.
        profileBGView.layer.cornerRadius = profileBGView.frame.height / 2
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
    }
    

}
