//
//  CitiesView.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit

protocol CityDelegate: class {
    func searchVideo(searchStr: String)
    func displaySelectedCityOnMap(cityInfo: CitiesModel)
}

class CitiesView: UIView {
    
    var citiesArr = [CitiesModel]()
    var searchCitiesArr = [CitiesModel]()

    weak var delegate: CityDelegate?
    var isSearch: Bool = false

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .singleLine
        table.separatorInset = .zero
        table.separatorColor = UIColor.gray
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10)
        return table
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.tintColor = UIColor.white
        searchBar.delegate = self
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func setUI() {
        self.addSearchBar()
        self.addTableView()
    }
    
    func addSearchBar() {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.white
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }

        self.addSubview(searchBar)
        self.setUpSearchBarConstraints()
    }
    
    func addTableView() {
        self.addSubview(tableView)
        tableView.contentInset = .zero
        self.setUpTableViewConstraints()
        tableView.register(CityCell.self, forCellReuseIdentifier: "cityCell")
    }
}

//#MARK:- Set up view's constraints
extension CitiesView {
    
    func setUpSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension CitiesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return searchCitiesArr.count
        } else {
            return citiesArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.cityData = isSearch ? searchCitiesArr[indexPath.row] : citiesArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentDelegate = delegate {
            let item = isSearch ? searchCitiesArr[indexPath.row] : citiesArr[indexPath.row]
            currentDelegate.displaySelectedCityOnMap(cityInfo: item)
        }
    }
}

extension CitiesView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search text:- \(searchText)")
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            self.isSearch = false
            self.tableView.reloadData()
            return
        }
        //Send notification to fetch video data according to a text enter by the user
        if delegate != nil {
            delegate?.searchVideo(searchStr: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearch = false
        self.tableView.reloadData()
    }
}
