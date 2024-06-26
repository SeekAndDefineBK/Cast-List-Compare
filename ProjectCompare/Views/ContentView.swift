//
//  ContentView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(TMDBAPI.self) var tmdb: TMDBAPI
    @AppStorage("selectedTab") var selectedTab: Int = 0
    
    var body: some View {
        TabView {
            VStack {
                Text("Description")
                
                Text("Person 1")
                
                Text("Person 2")
                
                Text("Compare Button")
            }
            .tag(0)
            
            VStack {
                Text("Settings")
                Text("History")
                Text("Attribution")
            }
            .tag(1)
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    ContentView()
}
