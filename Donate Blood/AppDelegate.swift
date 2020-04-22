//
//  AppDelegate.swift
//  Donate Blood
//
//  Created by RakiB on 20/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //splash screen duration time
        //Thread.sleep(forTimeInterval: 3.0)
        
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        // enable IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        // MARK: handle root view controller for lower ios 13
        if #available(iOS 13, *){
            
        }else{
            loadBaseController()
        }
        
        return true
    }
    func loadBaseController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let window = self.window else { return }
        window.makeKeyAndVisible()
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: "SplashScreenViewController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

