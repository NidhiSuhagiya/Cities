//
//  CitiesTests.swift
//  CitiesTests
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import XCTest
@testable import Cities

class CitiesTests: XCTestCase {

    var cityVC: CitiesVC!
    var citiesArr: [CitiesModel]!
    var searchCitiesArr: [CitiesModel]!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cityVC = CitiesVC()
        cityVC.viewDidLoad()
            citiesArr = cityVC.citiesView.citiesArr

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        cityVC = nil
    }

    func fetchCitiesData() {
        self.measure {
           
            // Put the code you want to measure the time of here.
//            XCTAssert(cities!.count, 1)

        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
//                    let citiesList = cityArr.sorted { (country1, country2) -> Bool in
//                                let countryName1 = country1.name
//                                let countryName2 = country2.name
//                                return countryName1.localizedCaseInsensitiveCompare(countryName2) == ComparisonResult.orderedAscending
//                            }
                        self.measure {
                            searchCitiesPerformanceExample()
            }
            // Put the code you want to measure the time of here.
        }
    
    func searchCitiesPerformanceExample() {
        let searchStr = "India"
//        cityVC.cityVM.searchCountryByText(searchStr: searchStr)
//        citiesArr.filter {
//            $0.fullCityAddr.range(of: searchStr, options: .caseInsensitive) != nil
//        }
        citiesArr = cityVC.cityVM.citiesArr
        self.binarySearch(inputArray: citiesArr, searchValue: searchStr)
    }
    
    func binarySearch(inputArray: [CitiesModel], searchValue: String) -> [CitiesModel] {
        var lowerIndex = 0
        var upperBound = inputArray.count - 1
        var searchCities = [CitiesModel]()
        while (true) {
            let currentIndex = (lowerIndex + upperBound) / 2
            if inputArray[currentIndex].name == searchValue {
                searchCities.append(inputArray[currentIndex])
            } else if (lowerIndex > upperBound) {
                
            } else {
                if inputArray[currentIndex].name > searchValue {
                    upperBound = currentIndex + 1
                    
                    
                    
                } else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
        return searchCities

    }
}
