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
        VStack {
            TextField("Enter Person Name", text: $query)
                .textFieldStyle(.roundedBorder)
            
            Button("Search") {
                performSearch()
            }
            
            List {
                ForEach(searchResults) { person in
                    Button {
                        withAnimation {
                            selectedPerson = person
                            dismiss()
                        }
                    } label: {
                        Text(person.name)
                    }
                    .foregroundStyle(.foreground)
                }
            }
            
            Text("Search result attribution")
        }
    }
    
    func performSearch() {
        Task {
            searchResults = await tmdb.searchForPerson(with: query, pageNumber: 1) ?? []
        }
    }
}
