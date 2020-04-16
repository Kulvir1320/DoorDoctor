//
//  MapView.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

class Coordinator: NSObject, MKMapViewDelegate{
    var control: Mapview
    
    init( _ control: Mapview){
        self.control = control
        
    }
    
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            
            if let annotation = annotationView.annotation {
                
                if annotation is MKUserLocation {
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1200, longitudinalMeters: 1200)
                    mapView.setRegion(region, animated: true)
                }
                
            }
        }
    }
    
    
    
    
    
    
}


struct Mapview: UIViewRepresentable{
    let landmarks: [Landmark]
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
        
}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<Mapview>) {
        
    updateAnnotations(from: uiView)
        
    }
    
    private func updateAnnotations(from mapView: MKMapView){
        
        
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
        
        
        
    }
    
}
