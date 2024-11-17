//
//  HistoryView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 11/17/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query var pastPeople: [Person]
    @Query var pastSearches: [SharedCreditsContainer]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("People")) {
                    ForEach(pastPeople) {
                        PersonProfileView(person: $0)
                    }
                }
                
                Section(header: Text("Comparisons")) {
                    ForEach(pastSearches) { search in
                        SharedCreditSummary(search)
                    }
                }
                
                
            }
            .navigationTitle("History")
        }
    }
}


#Preview {
    HistoryView()
}
