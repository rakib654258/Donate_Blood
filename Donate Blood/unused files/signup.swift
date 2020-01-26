//
//  signup.swift
//  Donate Blood
//
//  Created by RakiB on 20/1/20.
//  Copyright © 2020 RK. All rights reserved.
//

import UIKit

class signup: UIView {
    @IBOutlet var signupConView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var bloodGroupTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var confirmPassTF: UITextField!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
    }
    private func commonInit(){
        // we are going to do stuff here
        Bundle.main.loadNibNamed("signup", owner: self, options: nil)
        addSubview(signupConView)
        signupConView.frame = self.bounds
        signupConView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // MARK: textfields style
        Utilities.styleTextField(nameTF)
        Utilities.styleTextField(ageTF)
        Utilities.styleTextField(bloodGroupTF)
        Utilities.styleTextField(locationTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passTF)
        Utilities.styleTextField(confirmPassTF)
    }
    
}
