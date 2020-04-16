//
//  PlacesListView.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import SwiftUI
import MapKit

struct PlacesListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack{
                
            EmptyView()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.green)
            .gesture(TapGesture()
                .onEnded(self.onTap))
            
            
            List{
                
                
                ForEach(self.landmarks, id: \.id){
                    landmark in
                    
                    
                    VStack(alignment: .leading){
                        
                        Text(landmark.name)
                            .fontWeight(.bold)
                        Text(landmark.title)
                        
                    }
                }
                
                }.animation(nil)
            
        }.cornerRadius(10)
    }
}

struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesListView(landmarks: [Landmark(placemark: MKPlacemark())], onTap: {})
    }
}
