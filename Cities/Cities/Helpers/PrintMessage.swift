//
//  PrintMessage.swift
//  Cities
//
//  Created by JIRA on 12/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

struct PrintMessage {
    static func printToConsole(message : String) {
        #if DEBUG
        print(message)
        #endif
    }
}
