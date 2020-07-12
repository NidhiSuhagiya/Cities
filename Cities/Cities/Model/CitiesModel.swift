//
//  CitiesModel.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

struct CitiesModel : Codable {
    var country : String = ""
    let name : String
    let _id : Int?
    let coord : Coord?
}

struct Coord : Codable {
    let lat : Double?
    let lon : Double?
}
