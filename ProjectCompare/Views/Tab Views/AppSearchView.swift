//
//  AppSearchView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct AppSearchView: View {
    @StateObject private var viewModel = AppSearchViewModel()
    
    var body: some View {
        VStack {
            Text("How many times has")
                .font(.title)
                .bold()
            
            PersonContainer(person: $viewModel.person1)
            
            Text("been in the same movie as")
                .font(.title2)
                .bold()
            
            PersonContainer(person: $viewModel.person2)
                 
            Button {
                viewModel.showingCompare = true
            } label: {
                Text("Find out")
            }
            .accessibilityIdentifier("Compare")
            .buttonStyle(.borderedProminent) // signifies main action user should take
            .disabled(viewModel.person1 == nil || viewModel.person2 == nil)
        }
        .sheet(isPresented: $viewModel.searchForPerson1) {
            SearchPersonView(selectedPerson: $viewModel.person1)
        }
        .sheet(isPresented: $viewModel.searchForPerson2) {
            SearchPersonView(selectedPerson: $viewModel.person2)
        }
        .sheet(isPresented: $viewModel.showingCompare) {
            Group {
                if let person1 = viewModel.person1, let person2 = viewModel.person2 {
                    CompareView(person1: person1, person2: person2)
                } else {
                    // Fallback view in case person1 and or person2 is nil
                    Text("Error loading comparison view")
                }
            }
        }
        .padding()
    }
}

extension AppSearchView {
    class AppSearchViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person?
        @Published var person2: Person?
        @Published var searchForPerson1 = false
        @Published var searchForPerson2 = false
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
