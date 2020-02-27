//
//  donarDetailsDataModel.swift
//  Donate Blood
//
//  Created by RakiB on 2/2/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
import UIKit

class donarProfile{
    var name: String
    var blood_group: String
    var age: String? = nil
    var location: String
    var profile_img: String? = nil
    var mobile: String
    var available: Bool
    var currentUserID: String
    
    init(name: String, blood_group: String, age: String?, location: String, profile_img: String?, mobile: String, available: Bool,currentUserId: String) {
//    init(name: String, blood_group: String, location: String) {
        self.name = name
        self.blood_group = blood_group
        self.location = location
        self.profile_img = profile_img
        self.mobile = mobile
        self.available = available
        self.age = age
        self.currentUserID = currentUserId
    }
}
