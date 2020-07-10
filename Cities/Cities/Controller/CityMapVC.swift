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
    
    func addMapView() {
        mapView = MKMapView()
        mapView.center = self.view.center
        mapView.isZoomEnabled = true
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
        //        mapView.delegate = self
        self.view.addSubview(mapView)
        self.setUpMapViewConstraints()
    }
    
    func setUpMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setLocation() {
        if let selectedCoords = cityDetail?.coord {
            if let lat = selectedCoords.lat, let long = selectedCoords.lon {
                let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
                mapView.setCenter(center, animated: true)
                
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: center, latitudinalMeters: CLLocationDistance(exactly: 2000)!, longitudinalMeters: CLLocationDistance(exactly: 2000)!)//MKCoordinateRegion(center: center, span: span)
                
                self.mapView.setRegion(mapView.regionThatFits(region), animated: true) // Drop a pin at user’s Current Location
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

//class CityMapVC: UIViewController {
//
//    var mapView: CityMapView!
//    var selectedCoords: Coord?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.addMapView()
//        setUpMainViewConstraints()
//    }
//
//    func addMapView() {
//        mapView = CityMapView(coords: selectedCoords)
////        mapView.selectedCityCoord = selectedCoords
//        self.view.addSubview(mapView)
//    }
//}
//
////#MARK:- Set up view's constraints
//extension CityMapVC {
//    func setUpMainViewConstraints() {
//        self.mapView.translatesAutoresizingMaskIntoConstraints = false
//        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//}
