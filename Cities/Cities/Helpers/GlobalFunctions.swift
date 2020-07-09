//
//  GlobalFunctions.swift
//  Cities
//
//  Created by JIRA on 10/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit

class GlobalFunctions {
    
   static func setRootVC(vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.tintColor = UIColor.white
        nav.navigationBar.barTintColor = UIColor.black
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return nav
    }

}
