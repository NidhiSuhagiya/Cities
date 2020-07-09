//
//  CitiesCell.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
    
    var titleLbl: UILabel! //City + country code
    var latLongLbl: UILabel!
    
    lazy var lblStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
     var cityData: CitiesModel? {
        didSet {
            guard let cityDetail = cityData else { return  }
            
            if let cityName = cityDetail.name, let country = cityDetail.country {
                titleLbl.text = cityName + ", " + country
            }
            if let coordinates = cityDetail.coord {
                latLongLbl.text = "lat: \(String(describing: coordinates.lat)), long: \(String(describing: coordinates.lon))"
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        self.selectionStyle = .none
        setTitleLbl()
        setLatLongLbl()
        lblStackView.addArrangedSubview(titleLbl)
        lblStackView.addArrangedSubview(latLongLbl)
        self.contentView.addSubview(lblStackView)
        self.setUpStackViewConstraints()
    }
    
    func setTitleLbl() {
        titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLbl.textColor = UIColor.darkText
    }
    
    func setLatLongLbl() {
        latLongLbl = UILabel()
        latLongLbl.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        latLongLbl.textColor = UIColor.darkText
    }
    
}

//#MARK:- Set up view's constraints
extension CityCell {
    
    func setUpStackViewConstraints() {
        lblStackView.translatesAutoresizingMaskIntoConstraints = false
        lblStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        lblStackView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 10).isActive = true
        lblStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        lblStackView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        lblStackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
}
