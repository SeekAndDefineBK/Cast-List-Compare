//
//  PersonContainer.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import SwiftUI

struct PersonContainerView: View {
    @Binding var person: Person?
    @State var showingSearchPerson = false
    
    var body: some View {
        
        GroupBox {
            if let person = person {
                // Show Person Preview
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(maxWidth: 36, maxHeight: 36)
                    Text(person.name)
                    
                    Spacer()
                    
                    Button {
                        clearSelectedPerson()
                    } label: {
                        Label("Clear", systemImage: "x.circle")
                    }
                }
                
            } else {
                // Else instruct the user to search for a person
                Button {
                    showSearch()
                } label: {
                    Text("Search for a Person")
                }
            }
        }
        .sheet(isPresented: $showingSearchPerson) {
            SearchPersonView(selectedPerson: $person)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .onChange(of: person) { person in
            print("Person changed to: \(person?.name ?? "Nothing")")
        }
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
}
