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
        setUpMainView()
        fetchCitiesData()
    }
    
    func setNavBar() {
        self.navigationItem.title = "Cities"
    }
    
    func setUpMainView() {
        citiesView = CitiesView(frame: self.view.frame)
        citiesView.delegate = self
        self.view.addSubview(citiesView)
        setUpMainViewConstraints()
    }
    
    func fetchCitiesData() {
        cityVM.delegate = self
        cityVM.configView(view: self.citiesView)
    }
}

//#MARK:- Set up view's constraints
extension CitiesVC {
    func setUpMainViewConstraints() {
        self.citiesView.translatesAutoresizingMaskIntoConstraints = false
        self.citiesView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.citiesView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            self.citiesView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            self.citiesView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            self.citiesView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            self.citiesView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
}

//#MARK:- Fetch and display cities and error if failed
extension CitiesVC: DisplayCityDelegate {
    
    func searchVideo(searchStr: String) {
        cityVM.fetchSearchCity(searchStr: searchStr)
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

//#MARK:- Redirect to Map screen to display city on map
extension CitiesVC: CityDelegate {
    func displaySelectedCityOnMap(cityInfo: CitiesModel) {
        let mapVC = CityMapVC()
        mapVC.cityDetail = cityInfo
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}
