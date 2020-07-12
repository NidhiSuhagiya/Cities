//
//  CitiesCell.swift
//  Cities
//
//  Created by JIRA on 09/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit

final class CityCell: UITableViewCell {
    
    private var titleLbl: UILabel! //City + country code
    private var latLongLbl: UILabel!
    
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
            
            titleLbl.text = cityDetail.name + ", " + cityDetail.country
            if let coordinates = cityDetail.coord {
                if let latitude = coordinates.lat, let long = coordinates.lon {
                    latLongLbl.text = "lat: \(latitude), long: \(long)"
                }
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
    
    private func setUI() {
        self.selectionStyle = .none
        setTitleLbl()
        setLatLongLbl()
        setupLblStackView()
    }
    
    private func setTitleLbl() {
        titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLbl.textColor = UIColor.darkText
    }
    
    private func setLatLongLbl() {
        latLongLbl = UILabel()
        latLongLbl.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        latLongLbl.textColor = UIColor.darkText
    }
    
    private func setupLblStackView() {
        lblStackView.addArrangedSubview(titleLbl)
        lblStackView.addArrangedSubview(latLongLbl)
        self.contentView.addSubview(lblStackView)
        self.setUpStackViewConstraints()
    }
}

//#MARK:- Set up view's constraints
extension CityCell {
    
    private func setUpStackViewConstraints() {
        lblStackView.translatesAutoresizingMaskIntoConstraints = false
        lblStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        lblStackView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 10).isActive = true
        lblStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        lblStackView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        lblStackView.bottomAnchor.constraint(greaterThanOrEqualTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
}
