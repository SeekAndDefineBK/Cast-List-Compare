//
//  PersonCell.swift
//  ProjectCompare
//
//  Created by bk on 6/28/24.
//

import SwiftUI

struct PersonCell: View {
    @State private var viewModel: PersonCellModel
    
    init(person: Person, clearSelectedPerson: @escaping () -> Void) {
        let model = PersonCellModel(
            person: person,
            clearSelectedPerson: clearSelectedPerson
        )
        _viewModel = State(wrappedValue: model)
    }
    
    var body: some View {
        HStack {
            PersonProfileView(person: viewModel.person)
            
            Spacer()
            
            Button {
                viewModel.clearSelectedPerson()
            } label: {
                Label("Clear", systemImage: "x.circle")
            }
        }
    }
}

extension PersonCell {
    @Observable
    class PersonCellModel {
        // MARK: ViewModel Properties
        let person: Person
        let tmdb = TMDBAPI.shared
        let clearSelectedPerson: () -> Void
        
        // MARK: ViewModel Initializers
        init(person: Person, clearSelectedPerson: @escaping () -> Void) {
            self.person = person
            self.clearSelectedPerson = clearSelectedPerson
        }
                
        // MARK: ViewModel Methods
        func getImageRUL() -> URL? {
            tmdb.getImageURL(with: person.profile_path ?? "")
        }
    }
}
