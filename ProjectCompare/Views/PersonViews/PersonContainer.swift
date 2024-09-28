//
//  PersonContainer.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import SwiftUI

struct PersonContainer: View {
    @Binding var person: Person?
    @State var showingSearchPerson = false
    
    var body: some View {
        
        GroupBox {
            if let person = person {
                // Show Person Preview
                PersonCell(
                    person: person,
                    clearSelectedPerson: clearSelectedPerson
                )
            } else {
                // Else instruct the user to search for a person
                Button {
                    showSearch()
                } label: {
                    Text("Search for a Person")
                }
                .foregroundStyle(.white)
            }
        }
        .backgroundStyle(
            person == nil ? Color.blue : Color(uiColor: .quaternaryLabel).opacity(0.5)
        )
        .sheet(isPresented: $showingSearchPerson) {
            SearchPersonView(selectedPerson: $person)
        }
        .frame(maxWidth: .infinity)
        .accessibilityLabel(getPersonAccessibilityLabel(person))
        .padding()
    }
    
    func showSearch() {
        withAnimation {
            showingSearchPerson = true
        }
    }
    
    func clearSelectedPerson() {
        withAnimation {
            person = nil
        }
    }
    
    func getPersonAccessibilityLabel(_ person: Person?) -> String {
        if let person = person {
            return person.name
        } else {
            return "Select a person"
        }
    }
}
