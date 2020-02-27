//
//  RequestForBloodVC.swift
//  Donate Blood
//
//  Created by RakiB on 9/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class RequestForBloodVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var imageBG: CustomView!
    @IBOutlet weak var contrainerViewLbl: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var bloodTF: DropDown!
    @IBOutlet weak var hospitalTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var requestLbl: UIButton!
    
    let datePicker = UIDatePicker()
    var profile: donarProfile!
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodTF.delegate = self
        hospitalTF.delegate = self
        dateTF.delegate = self
        //hideKeyboardGesture()
        self.BloodGroupDropDown()
        textFieldSetup()
        
        //MARK:create datepicker
        dateTF.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace,doneButton], animated: true)
        dateTF.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
    }
    @objc func doneAction(){
        view.endEditing(true)
    }
    @objc func dateChange(){
        getDateFromPicker()
    }
    // MARK: textfield setup
    func textFieldSetup(){
        Utilities.styleTextField(bloodTF)
        Utilities.styleTextField(hospitalTF)
        Utilities.styleTextField(dateTF)
        

        if let profileImgUrl = profile.profile_img{
            self.profileImg.loadImageUsingCacheWithUrlString(urlString: profileImgUrl )
        }
        
        nameLbl.text = "Name : \(profile.name)"
        mobileLbl.text = "Mobile : \(profile.mobile)"
        locationLbl.text = "Location: \(profile.location)"
        imageBG.layer.cornerRadius = imageBG.frame.height / 2
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        requestLbl.layer.cornerRadius = requestLbl.frame.height / 2
    }
    // MARK:get date from date picker
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateTF.text = formatter.string(from: datePicker.date)
    }
    //MARK: Keyboard delegate return key active
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bloodTF{
            textField.resignFirstResponder()
            hospitalTF.becomeFirstResponder()
        }else if textField == hospitalTF{
            textField.resignFirstResponder()
            dateTF.becomeFirstResponder()
            //hideKeyboard()
        }else if textField == dateTF{
            textField.resignFirstResponder()
        }
        return true
    }
       //MARK: hide keyboard touches any where  NOTE: this gesture not worked because dropdown default gesture working
//    func hideKeyboardGesture(){
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
//        self.view.addGestureRecognizer(tapGesture)
//    }
//    @objc func tapGestureDone(){
//        self.view.endEditing(true)
//    }

    // MARK: set blood groups for dropdown selection
    func BloodGroupDropDown(){
        self.bloodTF.optionArray = ["O-","O+","A-","A+","B-","B+","AB-","AB+"]
        self.bloodTF.didSelect { (selectedGroup, index, id) in
            print("\(selectedGroup) selected")
        }
    }
    func validateField() -> String?{
        //check that all fields are filled in
        if bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || hospitalTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || dateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        return nil
    }
    // MARK:Send Request action
    @IBAction func sendRequestAction(_ sender: UIButton) {
        //validate the fields
        let error = validateField()
        if error != nil{
            //There's something wrong with the filed, show error
            showToast(error!)
        }
        else{
            //create cleaned versions of data
            let name = nameLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let location = locationLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let mobile = mobileLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let blood =  bloodTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let hospital = hospitalTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let date = dateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            print("Requested Info: \(profile.profile_img!), \(name!),\(location!),\(mobile!),\(blood!),\(hospital!),\(date!)")
            self.showToast("Request send Successfully")
        }
    }
    
}
