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
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var editBtnLbl: UIButton!
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var bloodTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var updateProfileLbl: UIButton!
    
    let db = Firestore.firestore()
    
    var proName = ""
    var currentUserID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigationbar back button
        self.title = "Profile"
//        let backButton = UIBarButtonItem()
//        backButton.title = "Back"
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
        updateProfileLbl.layer.cornerRadius = updateProfileLbl.frame.height / 2
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
        nameTF.isUserInteractionEnabled = false
        ageTF.isUserInteractionEnabled = false
        locationTF.isUserInteractionEnabled = false
        mobileTF.isUserInteractionEnabled = false
        availableSwitch.isUserInteractionEnabled = false
        
        updateProfileLbl.isHidden = true
        errorLbl.alpha = 0
    }
    func fetchUserData(){
            hud.showHUD()
            guard let userID = Auth.auth().currentUser?.uid else{return}
            print("Current user id is: \(userID)")
            currentUserID = userID
            // get user data
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
                        self.availableSwitch.isOn = data["available"] as? Bool ?? true
//                        if available == true{
//                            self.availableSwitch.isOn = true
//                        }else{
//                            self.availableSwitch.isOn = false
//                        }
                    }
                }
                
            }
        }
    
    
    @IBAction func editOrUpdateAction(_ sender: UIButton) {
        updateProfileLbl.isHidden = false
        editBtnLbl.isHidden = true
        nameTF.isUserInteractionEnabled = true
        locationTF.isUserInteractionEnabled = true
        ageTF.isUserInteractionEnabled = true
        mobileTF.isUserInteractionEnabled = true
        availableSwitch.isUserInteractionEnabled = true
    
    }
    @IBAction func updateProfileAction(_ sender: UIButton) {
        updateProfile()
        
    }
    func validateField() -> String?{
        //check that all fields are filled in
        if nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || locationTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ageTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
       return nil
    }
    func updateProfile(){
        //validate the fields
        let error = validateField()
        if error != nil{
            //There's something wrong with the filed, show error
            errorLbl.text = error
            errorLbl.alpha = 1
        }
        else{
            //create cleaned versions of data
            let name = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let blood =  bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let location = locationTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile = mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let age = ageTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            var available = true
            if availableSwitch.isOn == false{
                available = false
            }
            hud.showHUD()
            //update user data
            let userRef = db.collection("users").document(currentUserID)
            // set updated data
            userRef.updateData([
                "name": name!,
                "age": age!,
                "blood-group": blood!,
                "location": location!,
                "mobile": mobile!,
                "available": available,
                "lastUpdated": FieldValue.serverTimestamp()
            ]) { (error) in
                if let error = error{
                    hud.hideHUD()
                    self.errorLbl.text = error.localizedDescription
                    print("Error Updating document: \(error)")
                }else{
                    hud.hideHUD()
                    self.viewDidLoad()
                    self.editBtnLbl.isHidden = false
                    print("Document Successfully updated")
                }
            }
        }
    }
}
