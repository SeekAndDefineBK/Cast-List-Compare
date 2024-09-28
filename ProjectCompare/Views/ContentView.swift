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
    @Environment(\.colorScheme) var colorScheme

    init() {
        // This hides the tutorial for UI Testing
        #if DEBUG
        showTutorial = false
        #endif
    }
    
    // accessing through EnvironmentObject to reduce number of instances of TMDBAPI object allocated
    let tmdb = TMDBAPI.shared
    
    // store selectedTab in user defaults to allow user to start where they left off
    @AppStorage("selectedTab") var selectedTab: Int = 0
    
    // Allows the user to move the tab title to the top or bottom of the screen
    @AppStorage("titleOnTop") var titleOnTop: Bool = false
    
    // Show Tutorial to new users
    @AppStorage("showTutorial") var showTutorial: Bool = true

    @ViewBuilder
    func tabTitleBar() -> some View {
        TabTitleBar(
            currentTabSelection: $selectedTab,
            tabItems: [
                TabItem(view: Text("Search"), index: 0, symbol: "magnifyingglass"),
                TabItem(view: Text("App Info"), index: 1, symbol: "ellipsis.circle")
            ]
        )
        .shadow(radius: 2, x: 2, y: 2)
    }
    
    @ViewBuilder
    func backgroundFill() -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(Color(uiColor: .systemGray6))
            .padding()
            .shadow(radius: 2, x: 2, y: 2)
    }
    
    var body: some View {
        VStack {
            if titleOnTop {
                tabTitleBar()
            }
            
            TabView(selection: $selectedTab) {
                // MARK: Main Tab
                AppSearchView()
                .tag(0)
                .padding()
                .background {
                    backgroundFill()
                }

                // MARK: Secondary tab for Settings, History, Attribution
                AppInfoView()
                .tag(1)
                .padding()
                .background {
                    backgroundFill()
                }
            }
            .tabViewStyle(.page) // allows user to change tab with swipe
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            
            if !titleOnTop {
                tabTitleBar()
            }
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView()
                .onDisappear {
                    showTutorial = false // set showTutorial to false so that it only shows once
                }
                .presentationBackground(.ultraThinMaterial)
        }
    }
}

extension ContentView {
    class ContentViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var showingCompare = false
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
    }
}
