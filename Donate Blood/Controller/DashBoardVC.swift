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
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var iteamArray = ["DONARS LIST","TOTAL DONAR","FAQ","ABOUT US","REQUEST BLOOD"]
    var userName = ""
    //var iteamArray = ["ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS"]
    var estimateWidth = 160.0
    var cellMarginSize = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Dashboard"
        // register nib
        collectionView.register(UINib(nibName: "IteamCell", bundle: nil), forCellWithReuseIdentifier: "IteamCell")
        let signoutBtn = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(tapSignOut))
        self.navigationItem.rightBarButtonItem = signoutBtn
        // add multiple button
//        let iteam1 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(tapSignOut))
//        let iteam2 = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(tapSignOut))
//        self.navigationItem.leftBarButtonItems = [iteam1,iteam2]
        setupGrid()
        //profileImg.layer.cornerRadius = profileImg.layer.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchUserData()
    }
    func fetchUserData(){
        guard let userID = Auth.auth().currentUser?.uid else{return}
        print("Current user id is: \(userID)")
        // get user data
        let db = Firestore.firestore()
        //let docRef = db.collection("users").document("")
//        db.collection("users").document("\(userID)").getDocument { (snapshot, error) in
        db.collection("users").document(userID).getDocument { (snapshot, error) in
            if let error = error{
                print( "error getting user", error.localizedDescription)
            }else{
                if let data = snapshot?.data(){
                    print((data["name"] as! String))
                    self.userName = data["name"] as! String
                    //self.profileImg.image = UIImage(named: data["imageUrl"] as! String)
                    //print(data["imageUrl"] as! String)
                    self.profileName.text = self.userName//(data["name"] as! String)
                    //print(data["blood-group"])
                }
            }
            
        }
    }
    
    
    @IBAction func ProfileBtnAction(_ sender: UIButton) {
        let profile = self.storyboard?.instantiateViewController(identifier: "ProfileVC")
        self.navigationController?.pushViewController(profile!, animated: true)
        //print(userName)
        
//        self.view.window?.rootViewController = profile
//        self.view.window?.makeKeyAndVisible()
    }
    
    
    // MARK: signout user
    @objc func tapSignOut(){
        print("signout btn taped")
                    let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: .actionSheet)
//        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: .alert)
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
                print ("Error signing out: %@", signOutError)
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // collection view grid
    func setupGrid(){
          let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
          flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
          flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
      }
}

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
            let donarList = self.storyboard?.instantiateViewController(identifier: "DonarListVC") as! DonarListVC
            donarList.title = "Donar List"
            self.navigationController?.pushViewController(donarList, animated: true)
        }
        if indexPath.row == 2{
            let donarList = self.storyboard?.instantiateViewController(identifier: "DonarListVC") as! DonarListVC
            donarList.title = "Donar List"
            self.navigationController?.pushViewController(donarList, animated: true)
        }
        if indexPath.row == 3{
            let donarList = self.storyboard?.instantiateViewController(identifier: "DonarListVC") as! DonarListVC
            donarList.title = "Donar List"
            self.navigationController?.pushViewController(donarList, animated: true)
        }
        if indexPath.row == 4{
            let donarList = self.storyboard?.instantiateViewController(identifier: "DonarListVC") as! DonarListVC
            donarList.title = "Donar List"
            self.navigationController?.pushViewController(donarList, animated: true)
        }
       }
//    @objc func connected(_ sender: AnyObject){
//
//    }
}
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
