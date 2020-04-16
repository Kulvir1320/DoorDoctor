//
//  ContentView.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var search: String = ""
    @State private var tapped: Bool = false
    
    private func getNearbyLandmarks() {
        
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            if let response = response {
            let mapItems = response.mapItems
            self.landmarks = mapItems.map {
                Landmark(placemark: $0.placemark)
                }
                
            }
            
            
        }
        
    }
    
    
    func calculateOffset() -> CGFloat {
        
        if self.landmarks.count > 0 && !self.tapped {
        return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
            
    }
        else if self.tapped {
            
            return 100
        }
        else {
            return UIScreen.main.bounds.size.height
        }
        
    }
    
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Mapview(landmarks: landmarks)
            
            TextField("Search", text: $search, onEditingChanged: { _ in })
            {
                
                self.getNearbyLandmarks()
                
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
                .offset(y: 44)
            
            PlacesListView(landmarks: self.landmarks){
                self.tapped.toggle()
            }.animation(.spring())
                .offset(y: calculateOffset())
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
