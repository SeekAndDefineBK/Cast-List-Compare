//
//  SearchPersonView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import SwiftUI

struct SearchPersonView: View {
    @Environment(\.dismiss) var dismiss
    let tmdb = TMDBAPI.shared
    
    @State private var query: String = ""
    @State private var searchResults: [Person] = []
    @Binding var selectedPerson: Person?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List {
                Section {
                    ForEach(searchResults) { person in
                        Button {
                            withAnimation {
                                selectedPerson = person
                                dismiss()
                            }
                        } label: {
                            PersonProfileView(person: person)
                        }
                        .foregroundStyle(.foreground)
                    }
                    
                } header: {
                    Text(getPlural())
                } footer: {
                    if !searchResults.isEmpty {
                        TMDBAttributionView()
                        .padding(.vertical)
                        .padding(.bottom, 200) // in iOS 16 this adds extra space to the end to prevent the searchbox from overlapping the last item
                    }
                }
                
            }
            
            GroupBox {
                Button("Search") {
                    performSearch()
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 5) // this evenly places the search button from the search box
                
                TextField("Enter Person Name", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 40)
            }
            .backgroundStyle(.ultraThinMaterial)
            
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    func performSearch() {
        Task {
            searchResults = await tmdb.searchForPerson(with: query, pageNumber: 1) ?? []
        }
    }
    
    func getPlural() -> String {
        let count = searchResults.count
        
        return "\(count) Result\(count == 0 || count > 2 ? "s" : "")"
    }
}
