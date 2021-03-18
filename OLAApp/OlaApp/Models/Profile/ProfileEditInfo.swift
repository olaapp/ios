//
//  ProfileEditInfo.swift
//  AESApp
//
//  Created by Alex on 5/28/20.
//  Copyright © 2020 AES. All rights reserved.
//

import Foundation
import UIKit
import ETBinding


struct ProfileEditInfo {
    let name: String
    let lastName: String
}


class ProfileEditInfoModelData: NSObject {
    static let shared: ProfileEditInfoModelData = ProfileEditInfoModelData()
    let liveData = LiveData(data: ProfileEditInfo(name: "",lastName: ""))
    var NIC: Int = 0
    let name: String = ""
    let lastName: String = ""
}



