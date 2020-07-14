//
//  MapViewController.swift
//  SearchWithGoogleApiApp
//
//  Created by mac on 14.07.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController,GMSMapViewDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mapView = self.view as! GMSMapView
        mapView.delegate = self

        let latitude = Double(selectedAdressArray[0].lat)
        let longitude = Double(selectedAdressArray[0].lng)
        let adress = selectedAdressArray[0].formattedAddress

        mapView.camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 13)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        marker.title = adress
        marker.map = mapView
            
    }
    
    func mapView(_: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LocationDetailsViewController") as! LocationDetailsViewController
        self.present(nextViewController, animated:true, completion:nil)
        
        return true
    }
    
}
