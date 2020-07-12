//
//  CityMapVC.swift
//  Cities
//
//  Created by JIRA on 10/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CityMapVC: UIViewController {
    
    var mapView: MKMapView!
    var cityDetail: CitiesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMapView()
        self.setLocation()
    }
    
    private func addMapView() {
        mapView = MKMapView()
        mapView.center = self.view.center
        mapView.isZoomEnabled = true
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
        self.view.addSubview(mapView)
        self.setUpMapViewConstraints()
    }
    
    private  func setUpMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setLocation() {
        if let selectedCoords = cityDetail?.coord {
            if let lat = selectedCoords.lat, let long = selectedCoords.lon {
                let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
                mapView.setCenter(center, animated: true)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
                let region = MKCoordinateRegion(center: center, span: span)//MKCoordinateRegion(center: center, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)
                self.mapView.setRegion(region, animated: true) // Drop a pin at user’s Current Location  mapView.regionThatFits(region)
                
                let myAnnotation: MKPointAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = CLLocationCoordinate2DMake(lat, long)
                myAnnotation.title = cityDetail?.name
                self.mapView.addAnnotation(myAnnotation)
                self.mapView.showAnnotations(mapView.annotations, animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
