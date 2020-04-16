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
    var control: MapView
    
    init( _ control: MapView){
        self.control = control
        
    }
}


struct MapView: UIViewRepresentable{
    
    func makeUIView(context: Context) -> MKMapView {
        
        let map = MKMapView()
        map.showsUserLocation = true
        map.delegate = context.coordinator
        return map
        
}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
}
