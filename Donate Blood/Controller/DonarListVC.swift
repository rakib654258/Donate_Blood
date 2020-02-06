//
//  DonarListVC.swift
//  Donate Blood
//
//  Created by RakiB on 26/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import FirebaseFirestore
import VegaScrollFlowLayout

class DonarListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var profile: [donarProfile] = []
    //var profile: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DonarListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonarListCollectionViewCell")
        // Do any additional setup after loading the view.
        hud.showHUD()
        VegaScrolllayout()
        getData()
        
    }
    // get all user from firestore
    override func viewWillAppear(_ animated: Bool) {
        //hud.showHUD()
    }
    func getData(){
        let db = Firestore.firestore()
        
//        db.collection("users").whereField("blood-group", isEqualTo: "A+").addSnapshotListener { (<#QuerySnapshot?#>, <#Error?#>) in
//            <#code#>
//        }
        db.collection("users").getDocuments { (querySnapshot, error) in
            //print(querySnapshot?.documents)
            //hud.showHUD()
            if let error = error{
                print("error getting documents: \(error)")
                hud.hideHUD()
            }
                
            else{
                
                for document in querySnapshot!.documents{
                    //self.profile = document.data
                    print("\(document.documentID) => \(document.data())")
                    //self.profile.append(document)
                    let data = document.data()
                    let name = data["name"]
                    let blood = data["blood-group"]
                    let location = data["location"]
                    print(location as Any)
                    let profile = data["imageUrl"] ?? "nil"
                    let mobile = data["mobile"] ?? "nil"
                    let age = data["age"] ?? "nil"
                    let available = data["available"] ?? true
                    let User = donarProfile(name: name as! String, blood_group: blood as! String, age: age as! String, location: location as! String, profile_img: (profile as! String), mobile: mobile as! String, available: available as! Bool)
//                    let User = donarProfile(name: name as! String, blood_group: blood as! String, location: location as! String)
                    //print("donar img", data["imageUrl"])
                    self.profile.append(User)
                }
                //print("All users profile data: ",self.profile[0].available)
                hud.hideHUD()
                //print(self.profile)
                self.collectionView.reloadData()
            }
        }
    }
    
    //collectionview layout
    func VegaScrolllayout(){
          let layout = VegaScrollFlowLayout()
          collectionView.collectionViewLayout = layout
          layout.minimumLineSpacing = 8
          layout.itemSize = CGSize(width: collectionView.frame.width, height: 100)
          layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
      }

}
extension DonarListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 20
        return profile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonarListCollectionViewCell", for: indexPath) as! DonarListCollectionViewCell
//        cell.DonarProfileImg
        //cell.donarName.text = "Rakib"
        cell.donarName.text = profile[indexPath.row].name
        cell.number = profile[indexPath.row].mobile
        if let profileImgUrl = profile[indexPath.row].profile_img{
            cell.DonarProfileImg.loadImageUsingCacheWithUrlString(urlString: profileImgUrl )
        }
        let activeStatus = profile[indexPath.row].available
        if activeStatus == false{
            cell.activeStatus.backgroundColor = .red
        }
        
        return cell
    }
    
}
extension DonarListVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let donarProfileVC = self.storyboard?.instantiateViewController(identifier: "DonarProfileVC") as! DonarProfileVC
        
        donarProfileVC.donarProfile = [profile[indexPath.row]]
        
        self.navigationController?.pushViewController(donarProfileVC, animated: true)
        
        // didselect show activity
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderWidth = 3.0
//        cell?.layer.borderColor = UIColor.green.cgColor
//        //cell?.layer.cornerRadius = (cell?.layer.frame.height)! / 2
        
    }
}
