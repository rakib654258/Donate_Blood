//
//  ViewController.swift
//  Donate Blood
//
//  Created by RakiB on 20/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

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
    
    @IBAction func signupAction(_ sender: UIButton) {
    }
    
    @IBAction func signinAction(_ sender: UIButton) {
    }
}

