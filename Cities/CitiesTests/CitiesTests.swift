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

    var citiesArr: [CitiesModel] = []
    var searchCitiesArr: [CitiesModel] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.createCityArrList()
        do {
            try testDecoding()
        } catch {
            PrintMessage.printToConsole(message: "reading json error:- \(error.localizedDescription)")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        citiesArr.removeAll()
        searchCitiesArr.removeAll()
    }
    
    func testDecoding() throws {
        /// When the Data initializer is throwing an error, the test will fail.
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let jsonData = try Data(contentsOf: fileUrl)
                /// The `XCTAssertNoThrow` can be used to get extra context about the throw
                XCTAssertNoThrow(try JSONDecoder().decode([CitiesModel].self, from: jsonData))
            } catch {
                PrintMessage.printToConsole(message: "reading json error:- \(error.localizedDescription)")
            }
        }
    }
    
    func filterCitiesWithValidSearchTest1() {
        self.searchCitiesPerformanceExample(searchStr: "a")
        XCTAssert(searchCitiesArr.count == 6, "Success")
    }
    
    func filterCitiesWithValidSearchTest2() {
        self.searchCitiesPerformanceExample(searchStr: "s")
        XCTAssert(searchCitiesArr.count == 2, "Success")
    }
    
    func filterCitiesWithValidSearchTest3() {
        self.searchCitiesPerformanceExample(searchStr: "New york")
        XCTAssert(searchCitiesArr.count == 1, "Success")
    }

    func filterCitiesWithValidSearchTest4() {
        self.searchCitiesPerformanceExample(searchStr: "Alb")
        XCTAssert(searchCitiesArr.count == 1, "Success")
    }
    
    func filterCitiesWithValidSearchTest5() {
        self.searchCitiesPerformanceExample(searchStr: "Al")
        XCTAssert(searchCitiesArr.count == 3, "Success")
    }
    
    func filterCitiesWithInValidSearchTest() {
        self.searchCitiesPerformanceExample(searchStr: "12345")
        XCTAssertFalse(searchCitiesArr.count != 0)
    }
    
    func testPerformanceExample() {
        // Put the code you want to measure the time of here.
        // This is an example of a performance test case.
        filterCitiesWithValidSearchTest1()
        filterCitiesWithValidSearchTest2()
        filterCitiesWithValidSearchTest3()
        filterCitiesWithValidSearchTest4()
        filterCitiesWithValidSearchTest5()
        
        filterCitiesWithInValidSearchTest()

        
        //TODO:- Remove it later on
//        JsonServices().fetchCitiesList { (cities, error) in
//            if let city = cities {
//                self.citiesArr = city
//                self.searchCitiesPerformanceExample(searchStr: "In")
//            }
//        }
    }
    
    func searchCitiesPerformanceExample(searchStr: String) {
//        self.measure {
        searchCitiesArr.removeAll()
                if (!self.searchCitiesArr.isEmpty) {
                    self.searchCitiesArr = self.searchCitiesArr.filter { (city) -> Bool in
                        if city.name.lowercased().starts(with: searchStr.lowercased()) {
                            return city.name.lowercased().starts(with: searchStr.lowercased())
                        } else {
                            return city.country.lowercased().starts(with: searchStr.lowercased())
                        }
                    }
                    PrintMessage.printToConsole(message: "Search city arr for text \(searchStr):- result is \(searchCitiesArr)")
                } else {
                    self.searchCitiesArr = self.citiesArr.filter {
                        if $0.name.lowercased().starts(with: searchStr.lowercased()) {
                            return $0.name.lowercased().starts(with: searchStr.lowercased())
                        } else {
                            return $0.country.lowercased().starts(with: searchStr.lowercased())
                        }
                    }
                    PrintMessage.printToConsole(message: "Search city arr for text \(searchStr):- result is \(searchCitiesArr)")
                }
//        }
    }

    func createCityArrList() {
        let citiesCoord1 = Coord(lat: 21.17, lon: -72.83)
        let cityInfo1 = CitiesModel(country: "In", name: "Surat", _id: 1, coord: citiesCoord1)
        self.citiesArr.append(cityInfo1)
        
        let cityInfo2 = CitiesModel(country: "US", name: "Albuquerque", _id: 2, coord: citiesCoord1)
        self.citiesArr.append(cityInfo2)
        
        let cityInfo3 = CitiesModel(country: "AU", name: "Sydney", _id: 3, coord: citiesCoord1)
        self.citiesArr.append(cityInfo3)
        
        let cityInfo4 = CitiesModel(country: "US", name: "Arizona", _id: 4, coord: citiesCoord1)
        self.citiesArr.append(cityInfo4)

        let cityInfo5 = CitiesModel(country: "US", name: "Anaheim", _id: 5, coord: citiesCoord1)
        self.citiesArr.append(cityInfo5)
        
        let cityInfo6 = CitiesModel(country: "US", name: "New york", _id: 6, coord: citiesCoord1)
        self.citiesArr.append(cityInfo6)

        let cityInfo7 = CitiesModel(country: "US", name: "Alabama", _id: 7, coord: citiesCoord1)
        self.citiesArr.append(cityInfo7)

        let cityInfo8 = CitiesModel(country: "US", name: "Alabama1", _id: 8, coord: citiesCoord1)
        self.citiesArr.append(cityInfo8)

            }
}
