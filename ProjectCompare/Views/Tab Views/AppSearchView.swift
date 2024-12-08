//
//  AppSearchView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct AppSearchView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage("showingHistory") var shwowingHistory: Bool = false
    @State private var viewModel = AppSearchViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Search")
                    .bold()
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    viewModel.showingHistory = true
                } label: {
                    Label("History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Text("How many times has")
                .font(.title3)
                .bold()
            
            PersonContainer(person: $viewModel.person1)
            
            Text("been in the same movie as")
                .font(.title3)
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
        .frame(maxHeight: .infinity, alignment: .top)
        .sheet(isPresented: $viewModel.searchForPerson1) {
            SearchPersonView(selectedPerson: $viewModel.person1)
        }
        .sheet(isPresented: $viewModel.searchForPerson2) {
            SearchPersonView(selectedPerson: $viewModel.person2)
        }
        .sheet(isPresented: $viewModel.showingCompare) {
            Group {
                if let person1 = viewModel.person1, let person2 = viewModel.person2 {
                    CompareView(
                        person1: person1,
                        person2: person2,
                        modelContext: modelContext
                    )
                } else {
                    // Fallback view in case person1 and or person2 is nil
                    Text("Error loading comparison view")
                }
            }
        }
        .sheet(isPresented: $viewModel.showingHistory) {
            HistoryView()
        }
    }
}

extension AppSearchView {
    @Observable
    class AppSearchViewModel {
        // MARK: ViewModel Properties
        var person1: Person?
        var person2: Person?
        var searchForPerson1 = false
        var searchForPerson2 = false
        var showingCompare = false
        var showingHistory = false
        
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
