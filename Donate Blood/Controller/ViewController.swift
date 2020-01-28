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
    @IBOutlet weak var signupPassTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var signupErrorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // signupContrainer.regiter
        textFieldSetup()
        
    }
    func textFieldSetup(){
        // signin textfields style
        Utilities.styleTextField(signinEmailLbl)
        Utilities.styleTextField(signinPassLbl)
        // signup textfields style
        Utilities.styleTextField(signupNameTF)
        //Utilities.styleTextField(signupAgeTf)
        Utilities.styleTextField(bloodTF)
        Utilities.styleTextField(locationTF)
        Utilities.styleTextField(signupEmailTF)
        Utilities.styleTextField(signupPassTF)
        Utilities.styleTextField(confirmPassTF)
        // hide and unhide views
//        signinViewLbl.alpha = 1
//        signupViewLbl.alpha = 0
        //self.signupViewLbl.isHidden = true
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
    func BloodGroupDropDown(){
        bloodTF.optionArray = ["O-","O+","A-","A+","B-","B+","AB-","AB+"]
        bloodTF.didSelect { (selectedGroup, index, id) in
            print("\(selectedGroup) selected")
        }
    }
    
    // check the field and validate that the data is correct.
    func validateField() -> String?{
        //check that all fields are filled in
        if signupNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || locationTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || signupEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || signupPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || confirmPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
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
            let email = signupEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = signupPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let confirmPass = confirmPassTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            //create the user
            Auth.auth().createUser(withEmail: email!, password: confirmPass!) { (result, err) in
                if err != nil{
                //there was an error to creating the user
                    //self.signupErrorLbl.text = "Error creating user"
                    self.signupErrorLbl.text = err?.localizedDescription
                    self.signupErrorLbl.alpha = 1
                }
                else{
                    //user create successfully, now store data
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name,"blood-group":blood,"location":location, "uid":result?.user.uid]) { (error) in
                        if error != nil{
                            self.signupErrorLbl.text = "Error while saving user data"
                            self.signupErrorLbl.alpha = 1
                        }
                    }
                    //transition to the home screen
                    self.TransitionToDashboard()
                    //print(self.signupNameTF.text)
                }
            }
        }
    }
    
    @IBAction func signinAction(_ sender: UIButton) {
        //create the cleaned version of textfield
        let email = signinEmailLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = signinPassLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        //signin the user
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil{
                self.errorLbl.text = error?.localizedDescription
                //self.errorLbl.text = "error face to login"
                self.errorLbl.alpha = 1
            }else{
                print("user signed in")
                self.TransitionToDashboard()
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

