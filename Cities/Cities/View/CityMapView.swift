//
//  CityMapView.swift
//  Cities
//
//  Created by JIRA on 10/07/20.
//  Copyright © 2020 Nidhi_Suhagiya. All rights reserved.
//

import Foundation
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var pinCustomImageName:String!
}

class CityMapView: UIView {
    
    lazy var mapView: MKMapView = {
        let cityMap = MKMapView()
        cityMap.isZoomEnabled = true
        cityMap.mapType = .standard
        cityMap.showsUserLocation = true
        cityMap.isScrollEnabled = true
        cityMap.isUserInteractionEnabled = true
        return cityMap
    }()
    
    var selectedCountryCoord: Coord?
    
    convenience init(coords: Coord?) {
        self.init(frame: .zero)
        self.selectedCountryCoord = coords
        self.backgroundColor = UIColor.white
        self.addSubview(mapView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mapView.showsUserLocation = true
        self.addMapView()
        self.backgroundColor = UIColor.white
        self.setLocation()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func setLocation() {
        //            let locationObj = CLLocation(latitude: lat, longitude: long)
        if let lat = selectedCountryCoord?.lat, let long = selectedCountryCoord?.lon {
            let center = CLLocationCoordinate2D(latitude: 21.1702, longitude: -72.8311)
            mapView.setCenter(center, animated: true)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
            let region = MKCoordinateRegion(center: center, span: span)
            self.mapView.setRegion(region, animated: true) // Drop a pin at user’s Current Location
            
            let customAnnotation = CustomPointAnnotation()
            customAnnotation.pinCustomImageName = "ic_marker"
            customAnnotation.coordinate = center
            customAnnotation.title = "Surat"
            self.mapView.addAnnotation(MKAnnotationView(annotation: customAnnotation, reuseIdentifier: "pin").annotation!)
            
            //            let myAnnotation: MKPointAnnotation = MKPointAnnotation()
            //            myAnnotation.title = "Surat"
            //            myAnnotation.coordinate = CLLocationCoordinate2DMake(21.1702, -72.8311);
            //
            //            self.mapView.addAnnotation(myAnnotation)
            //            self.mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    func addMapView() {
        mapView.center = self.center
        mapView.delegate = self
        self.addSubview(mapView)
        self.setUpMapViewConstraints()
    }
}

extension CityMapView {
    func setUpMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension CityMapView: MKMapViewDelegate {
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("map not loaded")
    }
    
    //    MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPointAnnotation
        annotationView?.image = UIImage(named: customPointAnnotation.pinCustomImageName)
        
        return annotationView
    }
}
