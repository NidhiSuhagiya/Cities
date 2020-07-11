//
//  CitiesViewModel.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation

protocol DisplayCityDelegate: class {
    func sendErrorResponse(errorMessage: String, isError: Bool)
}

class CitiesViewModel {
    
    weak var delegate: DisplayCityDelegate?
    var countryView: CitiesView!
    
    var citiesArr: [CitiesModel] = [] {
        didSet {
            countryView.activityIndicator.stopAnimating()
            countryView.searchBar.isUserInteractionEnabled = true
            countryView.citiesArr = citiesArr
            countryView.tableView.reloadData()
        }
    }
    
    var searchCitiesArr: [CitiesModel] = [] {
        didSet {
            countryView.activityIndicator.stopAnimating()
            countryView.searchCitiesArr = searchCitiesArr
            countryView.tableView.reloadData()
        }
    }
    
    func configView(view: CitiesView) {
        self.countryView = view
        self.fetchCityList()
    }
    
    //   #MARK:- Read json to fetch city list
    func fetchCityList() {
        DispatchQueue.global(qos: .background).async {
            JsonServices().fetchCitiesList { (citiesList, error) in
                DispatchQueue.main.async {
                    
                    guard let cityLists = citiesList else {
                        self.sendErrorMessage(str: error ?? "failed to fetch list of cities.", isError: true)
                        PrintMessage.printToConsole(message: "error :- \(error ?? "failed to fetch list of cities.")")
                        return
                    }
                    self.citiesArr = cityLists
                    self.sortCitiesByAlphbets(a: &self.citiesArr, start: 0, end: self.citiesArr.count)
                }
            }
        }
    }
    
    //    func sortCityArr(cityArr: [CitiesModel]) {
    //        //        TODO:- Reduce the excution time which is currently takes approx. 60 seconds to sort
    //        //        let citiesList = cityArr.sorted { $0.name.lowercased() < $1.name.lowercased() }
    //
    //        //        let citiesList = cityArr.sorted { (country1, country2) -> Bool in
    //        //            let countryName1 = country1.name
    //        //            let countryName2 = country2.name
    //        //            return countryName1.localizedCaseInsensitiveCompare(countryName2) == ComparisonResult.orderedAscending
    //        //        }
    //    }
    
    //  notify controller to display error/success message to the user
    func sendErrorMessage(str: String, isError: Bool) {
        if let resultDelegate = delegate {
            resultDelegate.sendErrorResponse(errorMessage: str, isError: isError)
        }
    }
    
    //#MARK:-    Search city by user input
    final func searchCountryByText(searchStr: String) {
        //        searchCitiesArr = citiesArr.filter {
        //            $0.name.range(of: searchStr, options: .caseInsensitive) != nil
        //        }
        countryView.activityIndicator.startAnimating()
        if (searchStr.count > 1) && !self.searchCitiesArr.isEmpty {
            self.searchCitiesArr = self.searchCitiesArr.filter { (city) -> Bool in
                self.checkValueExistinArray(city: city, searchStr: searchStr)
            }
        } else {
            self.searchCitiesArr = self.citiesArr.filter { (city) -> Bool in
                self.checkValueExistinArray(city: city, searchStr: searchStr)
            }
        }
    }
    
    func checkValueExistinArray(city: CitiesModel, searchStr: String) -> Bool {
        if city.name.lowercased().starts(with: searchStr.lowercased()) {
            return city.name.lowercased().starts(with: searchStr.lowercased())
        } else {
            return city.country.lowercased().starts(with: searchStr.lowercased())
        }
    }
    
    //    Quick sort for better performance
    final func sortCitiesByAlphbets( a:inout [CitiesModel], start:Int, end:Int) {
        if (end - start < 2){
            return
        }
        let p = a[start + (end - start)/2]
        var l = start
        var r = end - 1
        while (l <= r){
            if (a[l].name < p.name){
                l += 1
                continue
            }
            if (a[r].name > p.name){
                r -= 1
                continue
            }
            let t = a[l]
            a[l] = a[r]
            a[r] = t
            l += 1
            r -= 1
        }
        sortCitiesByAlphbets(a: &a, start: start, end: r + 1)
        sortCitiesByAlphbets(a: &a, start: r + 1, end: end)
    }
}
