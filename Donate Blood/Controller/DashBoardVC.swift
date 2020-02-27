//
//  DashBoardVC.swift
//  Donate Blood
//
//  Created by RakiB on 23/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class DashBoardVC: UIViewController{

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var imageViewBG: CustomView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var iteamArray = ["DONARS LIST","REQUEST BLOOD","DONARS","FAQS","ABOUT US","SETTING"]
    
    var Myprofile: donarProfile!
    var profileLoaded = false
    var estimateWidth = 160.0
    var cellMarginSize = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: register nib
        collectionView.register(UINib(nibName: "IteamCell", bundle: nil), forCellWithReuseIdentifier: "IteamCell")
        setupGrid()
        setupNavigationBarIteam()
    }
    // MARK: navigationBarIteam setup
    private func setupNavigationBarIteam(){
        // let signoutBtn = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(tapSignOut))
        let signOutImg = UIImage(named: "menu")
        let signoutBtn = UIBarButtonItem(image: signOutImg, style: .done, target: self, action: #selector(tapSignOut))
        signoutBtn.image = signOutImg
        self.navigationItem.rightBarButtonItem = signoutBtn
        
        // add multiple button
        // self.navigationItem.leftBarButtonItems = [iteam1,iteam2]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUserData()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        imageViewBG.layer.cornerRadius = imageViewBG.frame.height / 2
    }
    // MARK: get current user data from firebase.
    func fetchUserData(){
        guard let userID = Auth.auth().currentUser?.uid else{return}
        print("Current user id is: \(userID)")
        // get user data
        let db = Firestore.firestore()
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            if let error = error{
                print( "error getting user", error.localizedDescription)
            }else{
                if let data = snapshot?.data(){
                    //let data = document.data()
                    let name = data["name"]
                    let blood = data["blood-group"]
                    let location = data["location"]
                    //print(location as Any)
                    let profile = data["imageUrl"] ?? "nil"
                    let mobile = data["mobile"] ?? "nil"
                    let age = data["age"] ?? "nil"
                    let available = data["available"] ?? true
                    let currentUserID = data["uid"]
                    let User = donarProfile(name: name as! String, blood_group: blood as! String, age: age as? String, location: location as! String, profile_img: (profile as! String), mobile: mobile as! String, available: available as! Bool, currentUserId: currentUserID as! String)
                    self.Myprofile = User
                    self.profileLoaded = true
                    self.profileName.text = name as? String
                    if let profileImgUrl = data["imageUrl"]{
                        self.profileImg.loadImageUsingCacheWithUrlString(urlString: profileImgUrl as! String)
                    }
                    
                }
            }
            
        }
    }
    
    
    @IBAction func ProfileBtnAction(_ sender: UIButton) {
        if profileLoaded == true{
            let ProfileVC = self.storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
            ProfileVC.profile = Myprofile
            self.navigationController?.pushViewController(ProfileVC, animated: true)
        }
        else{showToast("Wait sometimes! or check your net connections!")}
        
    }
    
    
    // MARK: signout user
    @objc func tapSignOut(){
        print("signout btn taped")
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",style: UIAlertAction.Style.destructive,handler: {(_: UIAlertAction!) in
            //Sign out action
            do {
                try Auth.auth().signOut()
                let LoginPage = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
                self.view.window?.rootViewController = LoginPage
                self.view.window?.makeKeyAndVisible()
                
            } catch let signOutError as NSError {
                //print ("Error signing out: %@", signOutError)
                self.showToast("Error signing out: \(signOutError)")
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: collection view grid
    func setupGrid(){
          let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
          flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
          flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
      }
}
// MARK: collection view datasource
extension DashBoardVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iteamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IteamCell", for: indexPath) as! IteamCell
        cell.iteamLbl.text = iteamArray[indexPath.row]
        let image = iteamArray[indexPath.row]
        cell.iteamImg.image = UIImage(named: image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let donarList = self.storyboard?.instantiateViewController(identifier: "DonarListVC") as! DonarListVC
            donarList.title = "Donar List"
            self.navigationController?.pushViewController(donarList, animated: true)
        }
        if indexPath.row == 1{
            if profileLoaded == true{
                let requestVC = self.storyboard?.instantiateViewController(identifier: "RequestForBloodVC") as! RequestForBloodVC
                requestVC.title = "Request Blood"
                requestVC.profile = Myprofile
                self.navigationController?.pushViewController(requestVC, animated: true)
            }else{
                showToast("Wait sometimes! or check your net connections!")
            }
            
        }
        if indexPath.row == 2{
            let totalDonarVC = self.storyboard?.instantiateViewController(identifier: "TotalDonarVC") as! TotalDonarVC
            totalDonarVC.title = "Donars"
            self.navigationController?.pushViewController(totalDonarVC, animated: true)
        }
        if indexPath.row == 3{
            let faqVC = self.storyboard?.instantiateViewController(identifier: "FAQVC") as! FAQVC
            faqVC.title = "FAQS"
            self.navigationController?.pushViewController(faqVC, animated: true)
        }
        if indexPath.row == 4{
            let aboutVC = self.storyboard?.instantiateViewController(identifier: "AboutVC") as! AboutVC
            aboutVC.title = "About Us"
            self.navigationController?.pushViewController(aboutVC, animated: true)
        }
       }
//    @objc func connected(_ sender: AnyObject){
//
//    }
}
// MARK: collection view flowlayout
extension DashBoardVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculatewidth()
        return CGSize(width: width, height: width)
    }
    func calculatewidth() -> CGFloat{
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMarginSize)*(cellCount - 1) - margin) / cellCount
        return width
    }
   
}


//extension DashBoardVC: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var iteamsCount: CGFloat = 2.0
//        if UIApplication.shared.statusBarOrientation != UIInterfaceOrientation.portrait{
//            iteamsCount = 3.0
//        }
//        return CGSize(width: self.view.frame.width/iteamsCount-20, height: 220/155 * (self.view.frame.width/iteamsCount-20))
//    }
//}
