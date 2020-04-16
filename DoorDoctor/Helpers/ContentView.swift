//
//  ContentView.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State private var search: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            
            MapView()
            
            TextField("Search", text: $search, onEditingChanged: { _ in })
            {
                
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
                .offset(y: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
