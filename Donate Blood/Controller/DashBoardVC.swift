//
//  DashBoardVC.swift
//  Donate Blood
//
//  Created by RakiB on 23/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class DashBoardVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var iteamArray = ["DONARS LIST","TOTAL DONAR","FAQ","ABOUT US","REQUEST BLOOD"]
    
    //var iteamArray = ["ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS","ALL DONARS"]
    var estimateWidth = 160.0
    var cellMarginSize = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Dashboard"
        // register nib
        collectionView.register(UINib(nibName: "IteamCell", bundle: nil), forCellWithReuseIdentifier: "IteamCell")
        setupGrid()
        //profileImg.layer.cornerRadius = profileImg.layer.frame.height / 2
    }
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
