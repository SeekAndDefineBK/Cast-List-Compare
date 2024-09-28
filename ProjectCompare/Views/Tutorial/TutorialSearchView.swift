//
//  TutorialSearchView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct TutorialSearchView: View {
    @StateObject private var viewModel = TutorialSearchViewModel()
    @Binding var person1: Person?
    @Binding var person2: Person?
    var continueAction: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Fill out the Search prompt")
                .bold()
                .font(.title)
            
            Spacer()
            
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
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .padding()
    }
}

extension TutorialSearchView {
    class TutorialSearchViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person?
        @Published var person2: Person?
        @Published var searchForPerson1 = false
        @Published var searchForPerson2 = false
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
