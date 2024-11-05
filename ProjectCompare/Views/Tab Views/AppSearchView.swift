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
        .accessibilityLabel(viewModel.accessibilityLabel)
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
        
        
        // MARK: Accessibility Properties
        var accessibilityLabel: String {
            if let person1, let person2 {
                return bothPeoplePresentLabel(person1.name, person2.name)
            } else if person1 != nil || person2 != nil {
                return missingOnePersonLabel
            } else {
                return missingBothPeopleLabel
            }
        }
        
        private func bothPeoplePresentLabel(_ personName1: String, _ personName2: String) -> String {
            "How many times as \(personName1) been in the same movie as \(personName2)."
        }
        
        private var missingOnePersonLabel: String {
            var personName = person1?.name
            
            if personName == nil {
                personName = person2?.name
            }

            return "Select another person to match productions with \(personName ?? "Unknown")"
        }
        
        private var missingBothPeopleLabel: String {
            "Find out how many times 2 people have been in the same production together."
        }
    }
}
