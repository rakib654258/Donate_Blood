//
//  ProfileVC.swift
//  Donate Blood
//
//  Created by RakiB on 2/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage


class ProfileVC: UIViewController {

    @IBOutlet weak var profileBGView: CustomView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var proPicEditBtn: UIButton!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var editBtnLbl: UIButton!
    @IBOutlet weak var availableSwitch: UISwitch!
    @IBOutlet weak var bloodTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var updateProfileLbl: UIButton!
    
    let db = Firestore.firestore()
    
    var profileImage: UIImage? = nil
    //var profileImage = UIImage(named: "profile")
    var profileImageUrl = ""
    var proName = ""
    var currentUserID = ""
    var isImageSelected = false
    
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
        proPicEditBtn.layer.cornerRadius = proPicEditBtn.frame.height / 2
        cancelBtn.layer.cornerRadius = cancelBtn.frame.height / 2
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
        cancelBtn.isHidden = true
        proPicEditBtn.isHidden = true
        
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
                        // MARK: download image from firebase
                        if let profileImgUrl = data["imageUrl"]{
                            self.profileImg.loadImageUsingCacheWithUrlString(urlString: profileImgUrl as! String)
                        }
                    }
                }
                
            }
        }
    
    
    @IBAction func editOrUpdateAction(_ sender: UIButton) {
        updateProfileLbl.isHidden = false
        cancelBtn.isHidden = false
        proPicEditBtn.isHidden = false
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
            var available = false
            if availableSwitch.isOn == true{
                available = true
            }
            hud.showHUD()
            //update user data
            let userRef = db.collection("users").document(currentUserID)
            
            // MARK: image set to firebase storage
            // load the profile image
        
            let storageRef = Storage.storage().reference(forURL: "gs://blooddonate-4fa96.appspot.com")
            let storageProfileRef = storageRef.child("profile").child(currentUserID)
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            if isImageSelected == true{
                let imageSelected = self.profileImage
                guard let imageData = imageSelected!.jpegData(compressionQuality: 0.5) else {
                    return
                }
                
                storageProfileRef.putData(imageData, metadata: metaData) { (storageMetaData, error) in
                    if error != nil{
                        print(error?.localizedDescription as Any)
                        return
                    }else{
                        print("Successfully uploaded image")
                    }
                    storageProfileRef.downloadURL { (url, error) in
                        if let metaImageUrl = url?.absoluteString{
                            print("url:",metaImageUrl)
                            self.profileImageUrl = metaImageUrl
                            userRef.updateData([
                                "imageUrl": self.profileImageUrl,
                            ])}}
                }
            }
            // MARK: set user updated data
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
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
//        let profile = self.storyboard?.instantiateViewController(identifier: "DashBoardVC")
//        self.navigationController?.pushViewController(profile!, animated: true)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func proPicEditAction(_ sender: UIButton) {
        photoChoseActionSheet()
    }
    
    
}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: image picker Action Sheet
    func photoChoseActionSheet(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        let actionSheet = UIAlertController(title: "Choose Source", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{return}
        if let cropedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImage = cropedImage
            profileImg.image = cropedImage
            isImageSelected = true
        }
            
//        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//            profileImage = originalImage
//            profileImg.image = originalImage
//        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
