//
//  UserProfile.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    var bandDescription: String?
    var BandImgUrl: String?
    var BandMembers: String?
    var BandName: String?
    var UserName: String?
    var BandSample: String?
    
    init(bandDescription: String,
         BandImgUrl: String,
         BandMembers: String,
         BandName: String,
         UserName: String,
         BandSample: String) {
        self.bandDescription = bandDescription
        self.BandImgUrl = BandImgUrl
        self.BandMembers = BandMembers
        self.BandName = BandName
        self.UserName = UserName
        self.BandSample = BandSample
    }

}
