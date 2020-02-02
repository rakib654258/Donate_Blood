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
    
    //var profile: [donarProfile] = []
    var profile: [String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DonarListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonarListCollectionViewCell")
        // Do any additional setup after loading the view.
        VegaScrolllayout()
        getData()
    }
    // get all user from firestore
    func getData(){
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querySnapshot, error) in
            //print(querySnapshot?.documents)
            if let error = error{
                print("error getting documents: \(error)")
            }
                
            else{
                for document in querySnapshot!.documents{
                    //self.profile = document.data()
                    //print("\(document.documentID) => \(document.data())")
                }
                //print(self.profile)
            }
        }
    }
    
    //collectionview layout
    func VegaScrolllayout(){
          let layout = VegaScrollFlowLayout()
          collectionView.collectionViewLayout = layout
          layout.minimumLineSpacing = 8
          layout.itemSize = CGSize(width: collectionView.frame.width, height: 80)
          layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
      }

}
extension DonarListVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonarListCollectionViewCell", for: indexPath) as! DonarListCollectionViewCell
//        cell.DonarProfileImg
        cell.donarName.text = "Rakib"
        
        return cell
    }
    
    
}
