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

                // MARK: Secondary tab for Settings, History, Attribution
                AppInfoView()
                .tag(1)
            }
            .tabViewStyle(.page) // allows user to change tab with swipe
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            
            if !titleOnTop {
                tabTitleBar()
            }
        }
        .background {
            LinearGradient(
                colors: [
                    viewModel.createGradientColor(for: colorScheme, color: .cyan), 
                    viewModel.createGradientColor(for: colorScheme, color: .green)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView()
                .onDisappear {
                    showTutorial = false // set showTutorial to false so that it only shows once
                }
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
        func createGradientColor(for colorScheme: ColorScheme, color: Color) -> Color {
            // determine the opacity given the color scheme
            let opacity = colorScheme == .light ? 0.2 : 0.5
            
            // return desired color with opacity applied
            return color.opacity(opacity)
        }
    }
}
