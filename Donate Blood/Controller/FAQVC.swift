//
//  FAQVC.swift
//  Donate Blood
//
//  Created by RakiB on 9/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
class FAQVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register tableview nib
        let nib = UINib(nibName: "FAQTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FAQTableViewCell")
        self.tableView.tableFooterView = UIView()
        //tableView.allowsSelection = false
    }

}

extension FAQVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qnsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        
        cell.qsnLbl.text = "Qsn : \(qnsArr[indexPath.row])"
        cell.ansLbl.text = "Ans : \(ansArr[indexPath.row])"
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // animation 1
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.3

        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
//        // animation 2
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0
//
//        UIView.animate(withDuration: 0.75) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//        }
    }
    
    
}

