//
//  ContentView2.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    
    @EnvironmentObject var tmdb: TMDBAPI
    @AppStorage("selectedTab") var selectedTab: Int = 0
    
    var body: some View {
        TabView {
            VStack {
                Text("Description")
                
                PersonContainerView(person: $viewModel.person1)
                Text("Person 1 = \(viewModel.person1?.name ?? "None")")
                
                PersonContainerView(person: $viewModel.person2)
                Text("Person  = \(viewModel.person2?.name ?? "None")")
                     
                Text("Compare Button")
            }
            .tag(0)
            .sheet(isPresented: $viewModel.searchForPerson1) {
                SearchPersonView(selectedPerson: $viewModel.person1)
            }
            .sheet(isPresented: $viewModel.searchForPerson2) {
                SearchPersonView(selectedPerson: $viewModel.person2)
            }
            
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

extension ContentView {
    class ContentViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person?
        @Published var person2: Person?
        @Published var searchForPerson1 = false
        @Published var searchForPerson2 = false
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
