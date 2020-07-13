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

final class CitiesView: UIView {
    
    weak var delegate: CityDelegate?
    var isSearch: Bool = false
    
    var citiesArr: [CitiesModel] = [] {
        didSet {
            self.activityIndicator.stopAnimating()
            self.searchBar.isUserInteractionEnabled = true
            self.noDataFoundLbl.isHidden = citiesArr.isEmpty ? false : true
            self.tableView.reloadData()
        }
    }
    
    var searchCitiesArr: [CitiesModel] = [] {
        didSet {
            self.activityIndicator.stopAnimating()
            self.noDataFoundLbl.isHidden = searchCitiesArr.isEmpty ? false : true
            self.tableView.reloadData()
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .whiteLarge
        loadingIndicator.color = UIColor.systemPink
        loadingIndicator.startAnimating()
        return loadingIndicator
    }()
    
    lazy var noDataFoundLbl: UILabel = {
        let noDataLbl = UILabel()
        noDataLbl.text = "No data found."
        noDataLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        noDataLbl.textAlignment = .center
        return noDataLbl
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorStyle = .none
        table.separatorInset = .zero
        table.separatorColor = UIColor.gray
        table.allowsSelection = true
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return table
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.tintColor = UIColor.white
        searchBar.delegate = self
        searchBar.isUserInteractionEnabled = false
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
    
    private func setUI() {
        self.addSearchBar()
        self.addTableView()
        self.addNodataLbl()
        self.addSubview(activityIndicator)
        self.setUpActivityIndicatorConstraints()
    }
    
    private func addSearchBar() {
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = UIColor.white
            textField.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        }
        
        self.addSubview(searchBar)
        self.setUpSearchBarConstraints()
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .zero
        
        self.addSubview(tableView)
        self.setUpTableViewConstraints()
        tableView.register(CityCell.self, forCellReuseIdentifier: "cityCell")
    }
    
    private func addNodataLbl() {
        tableView.backgroundView = noDataFoundLbl
        noDataFoundLbl.isHidden = true
        //        self.addSubview(noDataFoundLbl)
        noDataFoundLbl.center = tableView.center
    }
}

//#MARK:- Set up view's constraints
extension CitiesView {
    
    private func setUpSearchBarConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setUpTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setUpActivityIndicatorConstraints() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

//#MARK:- Tableview delegate and datasource methods
extension CitiesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            tableView.separatorStyle = (searchCitiesArr.count > 0) ? .singleLine : .none
            return searchCitiesArr.count
        } else {
            tableView.separatorStyle = (citiesArr.count > 0) ? .singleLine : .none
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
        self.endEditing(true)
        if let currentDelegate = delegate {
            let item = isSearch ? searchCitiesArr[indexPath.row] : citiesArr[indexPath.row]
            currentDelegate.displaySelectedCityOnMap(cityInfo: item)
        }
    }
}

//#MARK:- Search bar delegate
extension CitiesView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PrintMessage.printToConsole(message: "search text:- \(searchText)")
        searchCity(searchText: searchBar.text)
    }
    
    func searchCity(searchText: String?) {
        guard let textToSearch = searchText, !textToSearch.isEmpty else {
            self.isSearch = false
            self.searchCitiesArr = []
            self.tableView.reloadData()
            return
        }
        //Send notification to fetch video data according to a text enter by the user
        if delegate != nil {
            delegate?.searchVideo(searchStr: textToSearch)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.endEditing(true)
        self.isSearch = false
        self.searchCitiesArr = []
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Send notification to fetch video data according to a text enter by the user
        searchCity(searchText: searchBar.text)
        self.endEditing(true)
    }
}
