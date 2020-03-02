//
//  SplashScreenViewController.swift
//  Donate Blood
//
//  Created by RakiB on 2/3/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {
    
    let logoImage = UIImageView(image: UIImage(named: "LogoIcon"))
    let AppName = UILabel()
    let stackView = UIStackView()
    let splashView = UIView()
    
    var animationDone = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: create splashview
        splashScreen()
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.scaleDownAnimation()
        }
    }
    
    //MARK: create splashScreen
    func splashScreen(){
        splashView.backgroundColor = UIColor.white
        splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(splashView)
        // image view
        logoImage.contentMode = .scaleAspectFit
        //logoImage.frame = CGRect(x: splashView.frame.midX - 50, y: splashView.frame.midY - 50, width: 100, height: 100)
        logoImage.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        // text label
        AppName.widthAnchor.constraint(equalToConstant: self.view.frame.width - 64).isActive = true
        AppName.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        AppName.text = "Donate Blood"
        AppName.font = UIFont(name: "Times New Roman", size: 44)
        AppName.textAlignment = .center
        // stack view
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0
        // add view into stack view
        stackView.addArrangedSubview(logoImage)
        stackView.addArrangedSubview(AppName)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        splashView.addSubview(stackView)
        // centeralize stack view
        stackView.centerXAnchor.constraint(equalTo: self.splashView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.splashView.centerYAnchor).isActive = true
    }
    //MARK: splashview animation
    func scaleDownAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
//            self.logoImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.stackView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }) { (success) in
            self.scaleUpAnimation()
        }
    }
    func scaleUpAnimation(){
        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
//            self.logoImage.transform = CGAffineTransform(scaleX: 5, y: 5)
            self.stackView.transform = CGAffineTransform(scaleX: 5, y: 5)
        }) { (success) in
            self.removeSplashScreen()
        }
    }
    func removeSplashScreen(){
        UIView.animate(withDuration: 0.0, animations: {
            self.splashView.removeFromSuperview()
        }) { (success) in
            
            // MARK: check sign in or not
            if Auth.auth().currentUser == nil{
                let dashboard = self.storyboard?.instantiateViewController(identifier: "ViewController")
                self.view.window?.rootViewController = dashboard
                self.view.window?.makeKeyAndVisible()
            }else{
                let dashboard = self.storyboard?.instantiateViewController(identifier: "DashBoardVCNavigation")
                self.view.window?.rootViewController = dashboard
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
