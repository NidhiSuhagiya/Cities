//
//  CitiesViewModel.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

protocol DisplayCityDelegate {
    func displayCitiesData(cityArr: [CitiesModel])
    func sendErrorResponse(errorMessage: String, isError: Bool)
}

class CitiesViewModel {
    
    //    var citiesArr = [CitiesModel]()
    var delegate: DisplayCityDelegate?
    var view: CitiesView?
    
    func fetchCityList() {
        DispatchQueue.global(qos: .background).async {
            JsonServices.fetchCitiesList { (citiesList, error) in
                DispatchQueue.main.async {
                    
                    guard let cityLists = citiesList else {
                        self.sendErrorMessage(str: error ?? "failed to fetch list of cities.", isError: true)
                        print("error :- \(error)")
                        return
                    }
                    self.sortCityArr(cityArr: cityLists)
                }
                //                self.citiesArr = cityLists
            }
        }
    }
    
    func sortCityArr(cityArr: [CitiesModel]) {
        let citiesList = cityArr.sorted { $0.name.lowercased() < $1.name.lowercased() }

//        let citiesList = cityArr.sorted { (country1, country2) -> Bool in
//            let countryName1 = country1.name
//            let countryName2 = country2.name
//            return countryName1.localizedCaseInsensitiveCompare(countryName2) == ComparisonResult.orderedAscending
//        }
        if let currentDelegate = self.delegate {
            currentDelegate.displayCitiesData(cityArr: citiesList)
        }
    }
    
    //  notify controller to display error/success message to the user
    func sendErrorMessage(str: String, isError: Bool) {
        if let resultDelegate = delegate {
            resultDelegate.sendErrorResponse(errorMessage: str, isError: isError)
        }
    }
}
