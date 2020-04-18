//
//  MapVC.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{
    
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var landmarks = [Landmark]()
    var destination: CLLocationCoordinate2D?
    var source:  CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        getNearbyLandmark()
        
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDirection))
        
        mapView.addGestureRecognizer(tapGesture)
        
}
    

    
    
    @objc func showDirection(gesture: UITapGestureRecognizer){
        
        let allOverlays = mapView.overlays
        if allOverlays.count > 0 {
            mapView.removeOverlays(allOverlays)
            
        }
        
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        destination = coordinate
        
        let sourceplacemark = MKPlacemark(coordinate: source!)
                                      let destinationplacemark = MKPlacemark(coordinate: destination!)
                                      
                                      let sourceMapItem = MKMapItem(placemark: sourceplacemark)
                                      let destinationMapItem = MKMapItem(placemark: destinationplacemark)

                                      
                                      let directionRequest = MKDirections.Request()
                                      directionRequest.source = sourceMapItem
                                      directionRequest.destination = destinationMapItem
               directionRequest.transportType = .automobile
                              
                              print("after direction")
                                      
                                      let directions = MKDirections(request: directionRequest)
                                      
                                      directions.calculate { (response, error) in
                                          guard let response = response else{
                                              if let error = error{
                                               let alert = UIAlertController(title: "OOPS", message: "Directions not available", preferredStyle: .alert)
                                               let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                               alert.addAction(okAction)
                                               self.present(alert, animated: true, completion: nil)
                                                  print("Error: \(error)")
                                              }
                                              return
                                          }
                                          
                                          print("in calculate")
                                          
                                          let route = response.routes[0]
                                       self.mapView.addOverlay((route.polyline))
               //                           self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                                          print("add overlay")
                                          
                                          let rect = route.polyline.boundingMapRect
                                          self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                                          print("set region")
                                      
                                      }
                  
        
        
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
               
                   return renderer
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let userLocation: CLLocation = locations[0]
               
               let lat = userLocation.coordinate.latitude
               let long = userLocation.coordinate.longitude
               
               let latDelta: CLLocationDegrees = 0.1
               let longDelta: CLLocationDegrees = 0.1
               
               let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
               let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
               
               source = location
               
               let region = MKCoordinateRegion(center: location, span: span)
               mapView.setRegion(region, animated: true)
               
               getNearbyLandmark()
               
               for lmark in landmarks {
                   
                   print("inside for.................")
                   print(lmark.coordinate)
                   let annotaion = MKPointAnnotation()
                   print(lmark.coordinate)
                   annotaion.coordinate = lmark.coordinate
                   mapView.addAnnotation(annotaion)
               }
    }
    
    
    func  getNearbyLandmark(){
        
        
        let  request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "clinic"
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map{
                    Landmark(placemark: $0.placemark)
                }
            }
        }
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}