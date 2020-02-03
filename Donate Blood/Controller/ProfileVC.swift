//
//  ProfileVC.swift
//  Donate Blood
//
//  Created by RakiB on 2/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var profileBGView: CustomView!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var editBtnLbl: UIButton!
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var bloodTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
 
    var proName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(proName)
        // Do any additional setup after loading the view.
        roundShape()
        elementsSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchUserData()
    }
    func roundShape(){
        profileBGView.layer.cornerRadius = profileBGView.frame.height / 2
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        editBtnLbl.layer.cornerRadius = editBtnLbl.frame.height / 2
    }
    
    func elementsSetup(){
        // signin textfields style
        Utilities.styleTextField(nameTF)
        Utilities.styleTextField(ageTF)
        Utilities.styleTextField(locationTF)
        Utilities.styleTextField(bloodTF)
        Utilities.styleTextField(mobileTF)
        
        // disable textfield editing
        bloodTF.isUserInteractionEnabled = false
        availableSwitch.isUserInteractionEnabled = false
    }
    func fetchUserData(){
            hud.showHUD()
            guard let userID = Auth.auth().currentUser?.uid else{return}
            print("Current user id is: \(userID)")
            // get user data
            let db = Firestore.firestore()
            db.collection("users").document(userID).getDocument { (snapshot, error) in
                if let error = error{
                    hud.hideHUD()
                    print( "error getting user", error.localizedDescription)
                }else{
                    hud.hideHUD()
                    if let data = snapshot?.data(){
                        self.nameTF.text = data["name"] as? String
                        self.ageTF.text = data["age"] as? String ?? "nil"
                        self.locationTF.text = data["location"] as? String
                        self.bloodTF.text = data["blood-group"] as? String
                        self.mobileTF.text = data["mobile"] as? String ?? "+88"
                        let available = data["available"] as? Bool
                        if available == true{
                            self.availableSwitch.isOn = true
                        }else{
                            self.availableSwitch.isOn = false
                        }
                    }
                }
                
            }
    }
    
    
    @IBAction func editOrUpdateAction(_ sender: UIButton) {
    
    }
    
}
