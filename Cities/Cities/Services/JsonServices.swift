//
//  JsonServices.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

class JsonServices {
    
    final func fetchCitiesList(completionHandler: @escaping(([CitiesModel]?, String?) ->())) {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)// (contentsOf: fileUrl)
                let jsonObj = try JSONDecoder().decode([CitiesModel].self, from: data)
                
                //                let temp = data.withUnsafeBytes {
                //                    return $0.split(separator: UInt8(ascii: "\n")).map { String(decoding: UnsafeRawBufferPointer(rebasing: $0), as: UTF8.self) }
                //                }
                completionHandler(jsonObj, nil)
            } catch {
                PrintMessage.printToConsole(message: "error:- \(error.localizedDescription)")
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
}
