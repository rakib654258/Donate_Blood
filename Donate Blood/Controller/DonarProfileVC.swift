//
//  DonarProfileVC.swift
//  Donate Blood
//
//  Created by RakiB on 6/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class DonarProfileVC: UIViewController {
    
    @IBOutlet weak var imgBG: CustomView!
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var bloodLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    var donarProfile: [donarProfile] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Donar Profile"
        setUpElementns()
    }
    func setUpElementns(){
        imgBG.layer.cornerRadius = imgBG.frame.height / 2
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        callBtn.layer.cornerRadius = callBtn.frame.height / 2
        
//        profileImg.image
        nameLbl.text = ": \(donarProfile[0].name)"
        if let age = donarProfile[0].age{
            ageLbl.text = ": \(age)"
        }
        
        //ageLbl.text = "Age: \(donarProfile[0].age!)"
        locationLbl.text = ": \(donarProfile[0].location)"
        mobileLbl.text = ": \(donarProfile[0].mobile)"
        bloodLbl.text = ": \(donarProfile[0].blood_group)"
        let available = donarProfile[0].available
        if available == true{
            availableLbl.text = ": Yes"
        }else{
            availableLbl.text = ": No"
        }
        if let profileImgUrl = donarProfile[0].profile_img{
            self.profileImg.loadImageUsingCacheWithUrlString(urlString: profileImgUrl )
        }
        
    }
    
    @IBAction func callAction(_ sender: UIButton) {
        guard let number : NSURL = URL(string: "TEL://)\(donarProfile[0].mobile)") as NSURL?
            else{return}
        UIApplication.shared.open(number as URL, options: [:], completionHandler: nil)
    }
}
