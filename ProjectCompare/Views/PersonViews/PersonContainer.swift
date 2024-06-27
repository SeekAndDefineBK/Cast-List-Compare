//
//  PersonContainer.swift
//  ProjectCompare
//
//  Created by bk on 6/26/24.
//

import SwiftUI

struct PersonContainerView: View {
    @StateObject private var viewModel: PersonContainerModel
    init(person: Binding<Person?>) {
        // Initialize the view model before the view is done initializing
        let model = PersonContainerModel(
            person: person
        )
        _viewModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        
        GroupBox {
            if let person = viewModel.person {
                // Show Person Preview
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(maxWidth: 36, maxHeight: 36)
                    Text(person.name)
                    
                    Spacer()
                    
                    Button {
                        viewModel.clearSelectedPerson()
                    } label: {
                        Label("Clear", systemImage: "x.circle")
                    }
                }
                
            } else {
                // Else instruct the user to search for a person
                Button {
                    viewModel.showSearch()
                } label: {
                    Text("Search for a Person")
                }
            }
        }
        .sheet(isPresented: $viewModel.showingSearchPerson) {
            SearchPersonView(selectedPerson: $viewModel.person)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .onChange(of: viewModel.person) { person in
            print("Person changed to: \(person?.name ?? "Nothing")")
        }
    }
}

extension PersonContainerView {
    
    class PersonContainerModel: ObservableObject {
        // MARK: ViewModel Properties
        @Binding var person: Person?
        @Published var showingSearchPerson = false
        
        // MARK: ViewModel Initializers
        init(person: Binding<Person?>) {
            _person = person
        }
                
        // MARK: ViewModel Methods
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
}
