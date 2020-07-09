//
//  CitiesView.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit

class CitiesView: UIView {
    
    var citiesArr = [CitiesModel]()
    
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
        searchBar.tintColor = UIColor.black
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
        return citiesArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCell
        cell.cityData = citiesArr[indexPath.row]
        return cell
    }
}

extension CitiesView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text:- \(searchText)")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel pressed")
    }
}

