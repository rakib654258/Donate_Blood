//
//  ViewController.swift
//  Donate Blood
//
//  Created by RakiB on 20/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

//protocol UserUidDataPass {
//    func user_uid(uid: String)
//}

class ViewController: UIViewController {
// signin labels
    @IBOutlet weak var signinEmailLbl: UITextField!
    @IBOutlet weak var signinPassLbl: UITextField!
    @IBOutlet weak var signinViewLbl: CustomView!
    @IBOutlet weak var customSegmentedController: CustomSegmentedControl!
    @IBOutlet weak var errorLbl: UILabel!
    // signup textfields
     @IBOutlet weak var signupViewLbl: CustomView!
    @IBOutlet weak var signupNameTF: UITextField!
    //@IBOutlet weak var signupAgeTf: UITextField!
//    @IBOutlet weak var bloodTF: UITextField!
    @IBOutlet weak var bloodTF: DropDown!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var signupEmailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var signupPassTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var signupErrorLbl: UILabel!
    
    //var delegate:UserUidDataPass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TransitionToDashboard()
        textFieldSetup()
        
    }
    
    // MARK: fextfield design
    func textFieldSetup(){
        // signin textfields style
        Utilities.styleTextField(signinEmailLbl)
        Utilities.styleTextField(signinPassLbl)
        // signup textfields style
        Utilities.styleTextField(signupNameTF)
        //Utilities.styleTextField(signupAgeTf)
        Utilities.styleTextField(bloodTF)
        Utilities.styleTextField(locationTF)
        Utilities.styleTextField(mobileTF)
        Utilities.styleTextField(signupEmailTF)
        Utilities.styleTextField(signupPassTF)
        Utilities.styleTextField(confirmPassTF)
        // hide and unhide views
//        signinViewLbl.alpha = 1
//        signupViewLbl.alpha = 0
        //self.signupViewLbl.isHidden = true
    }
    
    //check user logedin or not
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidAppear(_ animated: Bool) {
        // check sign in or not
        if Auth.auth().currentUser == nil{
            return
        }else{
            TransitionToDashboard()
        }
        
    }
    @IBAction func customSegmentedControllerAction(_ sender: CustomSegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            UIView.animate(withDuration: 0.5) {
//                self.signinViewLbl.alpha = 1
//                self.signupViewLbl.alpha = 0
                self.signinViewLbl.isHidden = false
                self.signupViewLbl.isHidden = true
                
            }
            print("Signin Button Tapped")
        }
        if sender.selectedSegmentIndex == 1{
            UIView.animate(withDuration: 0.5) {
                self.BloodGroupDropDown()
                self.signupViewLbl.alpha = 1
//                self.signinViewLbl.alpha = 0
                self.signupViewLbl.isHidden = false
                self.signinViewLbl.isHidden = true
            }
            print("Signup Button Tapped")
        }
    }
    // MARK: set blood groups for dropdown
    func BloodGroupDropDown(){
        bloodTF.optionArray = ["O-","O+","A-","A+","B-","B+","AB-","AB+"]
        bloodTF.didSelect { (selectedGroup, index, id) in
            print("\(selectedGroup) selected")
        }
    }
    
    // check the field and validate that the data is correct.
    func validateField() -> String?{
        //check that all fields are filled in
        if signupNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || locationTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || signupEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || signupPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        // check if the password is secure
        let cleanedPassword = signupPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword!) == false{
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        return nil
    }
    @IBAction func signupAction(_ sender: UIButton) {
        //validate the fields
        let error = validateField()
        if error != nil{
            //There's something wrong with the filed, show error
            signupErrorLbl.text = error
            signupErrorLbl.alpha = 1
        }
        else{
            //create cleaned versions of data
            let name = signupNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let blood =  bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let location = locationTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile = mobileTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = signupEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = signupPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let confirmPass = confirmPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            //show loading hud
            //hud.show(in: view, animated: true)
            hud.showHUD()
            //create the user
            Auth.auth().createUser(withEmail: email!, password: confirmPass!) { (result, err) in
                if err != nil{
                    hud.hideHUD()
                    //there was an error to creating the user
                    //self.signupErrorLbl.text = "Error creating user"
                    self.signupErrorLbl.text = err?.localizedDescription
                    self.signupErrorLbl.alpha = 1
                }
                else{
                    //user create successfully, now store data
                    let db = Firestore.firestore()
                    db.collection("users").document("\(result?.user.uid ?? "Profile")").setData(["name":name as Any,"blood-group":blood as Any,"location":location as Any,"mobile": mobile!, "uid":result?.user.uid as Any]) { (error) in
                        if error != nil{
                            //hud.dismiss(animated: true)
                            hud.hideHUD()
                            self.signupErrorLbl.text = "Error while saving user data"
                            self.signupErrorLbl.alpha = 1
                        }
                    }
                    //hud.dismiss(animated: true)
                    
                    //transition to the home screen
                    self.TransitionToDashboard()
                    //self.showToast("signup successfully")
                    //dismiss the Loading HUD
                    hud.hideHUD()
                }
            }
        }
    }
    // MARK: signin action
    @IBAction func signinAction(_ sender: UIButton) {
        //create the cleaned version of textfield
        let email = signinEmailLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = signinPassLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //show loading hud
        hud.showHUD()
        //signin the user
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil{
                hud.hideHUD()
                self.errorLbl.text = error?.localizedDescription
                //self.errorLbl.text = "error face to login"
                self.errorLbl.alpha = 1
            }else{
                print("user signed in with id: \(result?.user.uid ?? "no id ")")
                //self.delegate.user_uid(uid: (result?.user.uid)!)
                self.TransitionToDashboard()
                hud.hideHUD()
            }
        }
    }
    
    func TransitionToDashboard(){
        let dashboard = self.storyboard?.instantiateViewController(identifier: "DashBoardVCNavigation") //as! DashBoardVC
        //self.navigationController?.pushViewController(dashboard, animated: true)
        self.view.window?.rootViewController = dashboard
        self.view.window?.makeKeyAndVisible()
    }
}

