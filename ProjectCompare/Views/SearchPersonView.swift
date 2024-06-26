//
//  SearchPersonView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import SwiftUI

struct SearchPersonView: View {
    @Environment(TMDBAPI.self) var tmdb: TMDBAPI
    
    @State private var query: String = ""
    @State private var searchResults: [Person] = []
    
    var body: some View {
        VStack {
            TextField("Enter Person Name", text: $query)
            
            Button("Search") {
                Task {
                    searchResults = await tmdb.searchForPerson(query: query, pageNumber: 1) ?? []
                }
            }
            
            List {
                ForEach(searchResults) { person in
                    Text(person.name)
                }
            }
            
            Text("Search result attribution")
        }
    }
}

#Preview {
    SearchPersonView()
}
