//
//  TutorialSearchView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct TutorialSearchView: View {
    @State private var viewModel = TutorialSearchViewModel()
    @Binding var person1: Person?
    @Binding var person2: Person?
    var continueAction: () -> Void

    var body: some View {
        VStack {
            Spacer()
            
            Text("You must select the people to search for")
            .padding(.vertical)
            
            Text("Who is the first person?")
                .bold()
            PersonContainer(person: $person1)
            
            Text("Who is the second person?")
                .bold()
            PersonContainer(person: $person2)
            
            Spacer()
            
            Button {
                continueAction()
            } label: {
                Text("Continue")
            }
            .disabled(person1 == nil || person2 == nil)
        }
    }
}

extension TutorialSearchView {
    @Observable
    class TutorialSearchViewModel {
        // MARK: ViewModel Properties
        var person1: Person?
        var person2: Person?
        var searchForPerson1 = false
        var searchForPerson2 = false
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
