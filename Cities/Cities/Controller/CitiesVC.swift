//
//  ViewController.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import UIKit

class CitiesVC: UIViewController {

    var nextStartRecord = 1
    var limit = 20
    
    var citiesView: CitiesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UIView.appearance().semanticContentAttribute = .forceLeftToRight

        setNavBar()
        // Do any additional setup after loading the view.
//        fetchCitiesData()
        setUpMainView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpMainViewConstraints()
    }
    
    func setNavBar() {
        self.navigationItem.title = "Home"
    }
    
    func setUpMainView() {
        citiesView = CitiesView(frame: self.view.frame)
        self.view.addSubview(citiesView)
        setUpMainViewConstraints()
    }

//    func fetchCitiesData() {
//        JsonServices.fetchCitiesData() {
//            self.nextStartRecord += self.limit            
//        }
//    }
}

//#MARK:- Set up view's constraints
extension CitiesVC {
    func setUpMainViewConstraints() {
        self.citiesView.translatesAutoresizingMaskIntoConstraints = false
        self.citiesView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.citiesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.citiesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.citiesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
