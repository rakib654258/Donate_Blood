//
//  LaunchScreenVC.swift
//  Donate Blood
//
//  Created by RakiB on 26/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {
    
    @IBOutlet weak var logoLbl: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.alpha = 1
        logoLbl.alpha = 1
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //FadeIn animation
        UIView.animate(withDuration: 0.5, animations: {
            self.logoLbl.alpha = 1
            self.titleLbl.alpha = 1
        }) { (true) in
            
            //UP to Down animation
            UIView.animate(withDuration: 0.5, animations: {
                self.logoLbl.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
                self.titleLbl.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
                //self.view.backgroundColor = UIColor.white
            }) { (success) in
                let sb = UIStoryboard(name: "Main", bundle: nil)
                //let vc = sb.instantiateViewController(withIdentifier: "MainStoryBoard")
                let vc = sb.instantiateInitialViewController()
                //                        UIApplication.shared.keyWindow?.rootViewController = vc
                UIApplication.shared.windows.first{$0.isKeyWindow}?.rootViewController = vc
                
            }
        }
        
    }
    
}
