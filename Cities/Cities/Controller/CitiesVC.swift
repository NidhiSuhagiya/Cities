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
    var cityVM = CitiesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setNavBar()
        // Do any additional setup after loading the view.
        fetchCitiesData()
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
        citiesView.delegate = self
        self.view.addSubview(citiesView)
        setUpMainViewConstraints()
    }

    func fetchCitiesData() {
        cityVM.delegate = self
        cityVM.fetchCityList()
    }
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


//#MARK:- Fetch and display cities and error if failed
extension CitiesVC: DisplayCityDelegate {
    
    func displayCitiesData(cityArr: [CitiesModel]) {
        self.citiesView.citiesArr = cityArr
        self.citiesView.tableView.reloadData()
    }
    
    func sendErrorResponse(errorMessage: String, isError: Bool) {
        showErrorSuccessDialog(isError: isError, errorMessage: errorMessage, vc: self)
    }
    
    func showErrorSuccessDialog(isError: Bool, errorMessage: String, vc: UIViewController) {
        let alert = UIAlertController(title: isError ? "Error" : "Success", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}

//#MARK:- Display city on map
extension CitiesVC: CityDelegate {
    func displaySelectedCityOnMap(cityInfo: CitiesModel) {
        let mapVC = CityMapVC()
        mapVC.cityDetail = cityInfo
//        mapVC.modalPresentationStyle = .formSheet
        
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}
