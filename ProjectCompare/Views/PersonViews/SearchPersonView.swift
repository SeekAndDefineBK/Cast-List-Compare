//
//  SearchPersonView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import SwiftUI
import SwiftData

struct SearchPersonView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.isFocused) var isFocused
    
    @Binding var selectedPerson: Person?
    
    @FocusState private var keyboardFocused: Bool
    
    @State private var vm = viewModel()
    @Query var pastPeople: [Person]
    
    @ViewBuilder
    func SelectPersonButton(_ person: Person, fromHistory: Bool) -> some View {
        Button {
            withAnimation {
                selectedPerson = person
                
                if !fromHistory {
                    modelContext.insert(person)
                    try? modelContext.save()
                    
                }
                
                dismiss()
            }
        } label: {
            PersonProfileView(person: person)
        }
        .foregroundStyle(.foreground)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                if vm.searchResults.isEmpty {
                    Section {
                        ForEach(pastPeople.prefix(10)) { person in
                            SelectPersonButton(person, fromHistory: true)
                        }
                        
                        if pastPeople.count > vm.historyPrefix {
                            Button {
                                withAnimation {
                                    vm.updateHistoryPrefix()
                                }
                            } label: {
                                Label("More", systemImage: "arrow.2.circlepath.circle")
                            }
                        }
                    } header: {
                        Text("History")
                    }
                } else {
                    Section {
                        ForEach(vm.searchResults) { person in
                            SelectPersonButton(person, fromHistory: false)
                        }
                    } header: {
                        Text(vm.getPlural())
                    } footer: {
                        if !vm.searchResults.isEmpty {
                            TMDBAttributionView()
                            .padding(.vertical)
                            .padding(.bottom, 200) // in iOS 16 this adds extra space to the end to prevent the searchbox from overlapping the last item
                        }
                    }
                }
            }
            
            GroupBox {
                Button("Search") {
                    vm.performSearch()
                    keyboardFocused = false
                }
                .accessibilityIdentifier("searchForPerson")
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 5) // this evenly places the search button from the search box
                
                TextField("Enter Person Name", text: $vm.query)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 40)
                    .focused($keyboardFocused)
                    
            }
            .backgroundStyle(.ultraThinMaterial)
        }
        .ignoresSafeArea(edges: keyboardFocused ? [] : [.bottom]) // MARK: without this the keyboard will overlap the text box
    }
    
    
}

extension SearchPersonView {
    @Observable
    class viewModel {
        let tmdb = TMDBAPI.shared
        
        var query: String = ""
        var searchResults: [Person] = []
        var historyPrefix: Int = 10
        
        func performSearch() {
            Task {
                searchResults = await tmdb.searchForPerson(with: query, pageNumber: 1) ?? []
            }
        }
        
        func getPlural() -> String {
            let count = searchResults.count
            
            return "\(count) Result\(count == 0 || count > 2 ? "s" : "")"
        }
        
        func updateHistoryPrefix() {
            historyPrefix = historyPrefix + 10
        }
    }
}
