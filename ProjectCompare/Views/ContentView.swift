//
//  ContentView2.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import SwiftUI
import TabTitleBar

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    // accessing through EnvironmentObject to reduce number of instances of TMDBAPI object allocated
    let tmdb = TMDBAPI.shared
    
    // store selectedTab in user defaults to allow user to start where they left off
    @AppStorage("selectedTab") var selectedTab: Int = 0
        
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                // MARK: Main Tab
                VStack {
                    Text("Description")
                    
                    PersonContainer(person: $viewModel.person1)
                    PersonContainer(person: $viewModel.person2)
                         
                    Button {
                        viewModel.showingCompare = true
                    } label: {
                        Text("Compare")
                    }
                    .buttonStyle(.borderedProminent) // signifies main action user should take
                    .disabled(viewModel.person1 == nil || viewModel.person2 == nil)
                    
                }
                .tag(0)

                // MARK: Secondary tab for Settings, History, Attribution
                VStack {
                    Text("Settings")
                    Text("History")
                    Text("Attribution")
                }
                .tag(1)
            }
            TabTitleBar(
                currentTabSelection: $selectedTab,
                tabItems: [
                    TabItem(view: Text("Search"), index: 0, symbol: "magnifyingglass"),
                    TabItem(view: Text("App Info"), index: 1, symbol: "ellipsis.circle")
                ]
            )
        }
        
        .tabViewStyle(.page) // allows user to change tab with swipe
        .sheet(isPresented: $viewModel.searchForPerson1) {
            SearchPersonView(selectedPerson: $viewModel.person1)
        }
        .sheet(isPresented: $viewModel.searchForPerson2) {
            SearchPersonView(selectedPerson: $viewModel.person2)
        }
        .sheet(isPresented: $viewModel.showingCompare) {
            if let person1 = viewModel.person1, let person2 = viewModel.person2 {
                CompareView(person1: person1, person2: person2)
            } else {
                // Fallback view in case person1 and or person2 is nil
                Text("Error loading comparison view")
            }
            
        }
    }
}

extension ContentView {
    class ContentViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person?
        @Published var person2: Person?
        @Published var searchForPerson1 = false
        @Published var searchForPerson2 = false
        @Published var showingCompare = false
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
