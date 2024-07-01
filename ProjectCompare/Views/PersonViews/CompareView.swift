//
//  CompareView.swift
//  ProjectCompare
//
//  Created by bk on 6/27/24.
//

import SwiftUI

struct CompareView: View {
    @StateObject private var viewModel: CompareViewModel
    
    init(person1: Person, person2: Person) {
        let model = CompareViewModel(person1: person1, person2: person2)
        _viewModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Give the user the rest of the details
            List {
                if !(viewModel.sharedCredits?.movieCredits.isEmpty ?? true) {
                    Section("Movies") {
                        ForEach(viewModel.sharedCredits?.movieCredits ?? []) {
                            CreditCompareView(credit: $0)
                                .padding(.vertical)
                        }
                    }
                }
                
                if !(viewModel.sharedCredits?.tvCredits.isEmpty ?? true) {
                    Section("TV") {
                        ForEach(viewModel.sharedCredits?.tvCredits ?? []) {
                            CreditCompareView(credit: $0)
                                .padding(.vertical)
                        }
                    }
                }
                
                if !(viewModel.sharedCredits?.sharedCredits.isEmpty ?? true) {
                    Section {
                        //
                    } footer: {
                        TMDBAttributionView()
                        .padding(.vertical)
                        .padding(.bottom, 200) // in iOS 16 this adds extra space to the end to prevent the searchbox from overlapping the last item
                    }
                }
            }
            
            // MARK: Summarize the data for the user
            GroupBox {
                ViewThatFits(in: .horizontal) {
                    HStack {
                        PersonProfileView(person: viewModel.person1)
                        PersonProfileView(person: viewModel.person2)
                    }
                    
                    VStack {
                        PersonProfileView(person: viewModel.person1)
                        PersonProfileView(person: viewModel.person2)
                    }
                }
                .padding()
                
                Text("\(viewModel.person1.name) and \(viewModel.person2.name) have been in \(viewModel.getPlural()) together")
                    .padding()
            }
            .backgroundStyle(.ultraThinMaterial)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension CompareView {
    @MainActor
    class CompareViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person
        @Published var person2: Person
        
        let tmdb = TMDBAPI.shared
        
        @Published var sharedCredits: SharedCreditsContainer? = nil
        
        // MARK: ViewModel Initializers
        init(person1: Person, person2: Person) {
            _person1 = Published(wrappedValue: person1)
            _person2 = Published(wrappedValue: person2)
            
            Task {
                await getCredits()
            }
        }
                
        // MARK: ViewModel Methods
        
        /// Fetches credits from tmdbapi and builds sharedCredits property
        func getCredits() async {
            let person1Credits = await tmdb.getCredits(for: person1)
            let person2Credits = await tmdb.getCredits(for: person2)
            
            guard let person1Credits = person1Credits, let person2Credits = person2Credits else {
                return
            }
            
            sharedCredits = SharedCreditsContainer(
                person1: person1,
                person2: person2,
                person1Credits: person1Credits,
                person2Credits: person2Credits
            )
        }
        
        // Convenience phrasing constructor for if production should be plural
        func getPlural() -> String {
            let count = sharedCredits?.sharedCredits.count ?? 0
            
            return "\(count) production\(count == 0 || count > 2 ? "s" : "")"
        }
    }
}
