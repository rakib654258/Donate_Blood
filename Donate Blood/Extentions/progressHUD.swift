//
//  progressHUD.swift
//  Donate Blood
//
//  Created by RakiB on 29/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
//import JGProgressHUD
//constract the progress
//let hud: JGProgressHUD = {
    //let hud = JGProgressHUD(style: .dark)
    //hud.interactionType = .blockAllTouches
    //hud.textLabel.text = "Loading"
//    hud.vibrancyEnabled = true
//    hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10, right: 0.0)
    //hud.textLabel.font = UIFont.systemFont(ofSize: 24.0)
    //hud.position = .center
    //hud.vibrancyEnabled = true
    //hud.cornerRadius = 20
    //return hud
//}()

import ACProgressHUD_Swift

let hud: ACProgressHUD = {
    let progressView = ACProgressHUD.shared
    progressView.progressText = "Loading.."
    progressView.backgroundColor = .black
    progressView.backgroundColorAlpha = 0.7
    progressView.enableBackground = true
    progressView.shadowColor = .black
    progressView.cornerRadius = 10.0
    progressView.shadowRadius = 10.0
//    progressView.showHudAnimation = .bounceFromTop
//    progressView.dismissHudAnimation = .bounceToBottom
    progressView.showHudAnimation = .bounceIn
    progressView.dismissHudAnimation = .bounceOut
//    progressView.showHudAnimation = .growIn
//    progressView.dismissHudAnimation = .growOut or fadeOut
    
    return progressView
}()
