//
//  TotalDonarVC.swift
//  Donate Blood
//
//  Created by RakiB on 9/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import Firebase

class TotalDonarVC: UIViewController {

    @IBOutlet weak var ABPositiveLbl: UILabel!
    @IBOutlet weak var ABNegetiveLbl: UILabel!
    @IBOutlet weak var BPositiveLbl: UILabel!
    @IBOutlet weak var ONegetiveLbl: UILabel!
    @IBOutlet weak var OPositiveLbl: UILabel!
    @IBOutlet weak var BNegetiveLbl: UILabel!
    @IBOutlet weak var ANegetiveLbl: UILabel!
    @IBOutlet weak var APositiveLbl: UILabel!
    @IBOutlet weak var totalDonarsLbl: UILabel!
    
    var blood = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //APositiveLbl.layer.masksToBounds = true
        setUpView()
        getData()
        
        // Do any additional setup after loading the view.
    }

    func setUpView(){
        APositiveLbl.layer.cornerRadius = APositiveLbl.frame.height / 2
        //ANegetiveLbl.layer.cornerRadius = ANegetiveLbl.frame.height / 2
        BPositiveLbl.layer.cornerRadius = BPositiveLbl.frame.height / 2
        //BNegetiveLbl.layer.cornerRadius = BNegetiveLbl.frame.height / 2
        OPositiveLbl.layer.cornerRadius = OPositiveLbl.frame.height / 2
        //ONegetiveLbl.layer.cornerRadius = ONegetiveLbl.frame.height / 2
        ABPositiveLbl.layer.cornerRadius = ABPositiveLbl.frame.height / 2
        //ABNegetiveLbl.layer.cornerRadius = ABNegetiveLbl.frame.height / 2
        totalDonarsLbl.layer.cornerRadius = totalDonarsLbl.frame.height / 2
    }
    func getData(){
        hud.showHUD()
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (querysnapShot, error) in
            if let error = error{
                hud.hideHUD()
                print("Error: \(error.localizedDescription)")
            }else{
                hud.hideHUD()
                if let data = querysnapShot?.count{
                    self.totalDonarsLbl.text = "Total Donars: \(data)"
                }
            }
        }
        // get by A+ blood group
        db.collection("users").whereField("blood-group", isEqualTo: "A+").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.APositiveLbl.text = "A(+ve) Donars: \(data)"
                }
            }
        }
        // get by A- blood group
        db.collection("users").whereField("blood-group", isEqualTo: "A-").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.ANegetiveLbl.text = "A(-ve) Donars: \(data)"
                }
            }
        }
        // get by B+ blood group
        db.collection("users").whereField("blood-group", isEqualTo: "B+").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.BPositiveLbl.text = "B(+ve) Donars: \(data)"
                }
            }
        }
        // get by B- blood group
        db.collection("users").whereField("blood-group", isEqualTo: "B-").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.BNegetiveLbl.text = "B(-ve) Donars: \(data)"
                }
            }
        }
        // get by O+ blood group
        db.collection("users").whereField("blood-group", isEqualTo: "O+").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.OPositiveLbl.text = "O(+ve) Donars: \(data)"
                }
            }
        }
        // get by O- blood group
        db.collection("users").whereField("blood-group", isEqualTo: "O-").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                     self.ONegetiveLbl.text = "O(-ve) Donars: \(data)"
                }
            }
        }
        // get by AB+ blood group
        db.collection("users").whereField("blood-group", isEqualTo: "AB+").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                     self.ABPositiveLbl.text = "AB(+ve) Donars: \(data)"
                }
            }
        }
        // get by AB- blood group
        db.collection("users").whereField("blood-group", isEqualTo: "AB-").getDocuments() { (querySnapshot, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else{
                if let data = querySnapshot?.count{
                    self.ABNegetiveLbl.text = "AB(-ve) Donars: \(data)"
                }
            }
        }
        
    }

}
