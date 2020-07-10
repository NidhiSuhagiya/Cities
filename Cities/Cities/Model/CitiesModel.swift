//
//  CitiesModel.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

struct CitiesModel : Codable {
    let country : String?
    let name : String
    let _id : Int?
    let coord : Coord?

    enum CodingKeys: String, CodingKey {

        case country = "country"
        case name = "name"
        case _id = "_id"
        case coord = "coord"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        _id = try values.decodeIfPresent(Int.self, forKey: ._id)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
    }
}

struct Coord : Codable {
    let lon : Double?
    let lat : Double?

    enum CodingKeys: String, CodingKey {

        case lon = "lon"
        case lat = "lat"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
    }

}
