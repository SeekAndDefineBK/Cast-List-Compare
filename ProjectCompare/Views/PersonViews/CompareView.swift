//
//  CompareView.swift
//  ProjectCompare
//
//  Created by bk on 6/27/24.
//

import SwiftUI

struct CompareView: View {
    @State private var viewModel: CompareViewModel
    
    init(person1: Person, person2: Person) {
        let model = CompareViewModel(person1: person1, person2: person2)
        _viewModel = State(wrappedValue: model)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // MARK: Give the user the rest of the details
            // if there are no shared productions, be explicit
            if viewModel.sharedCredits?.sharedCredits.isEmpty ?? true {
                Text("0 Shared Productions.")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) //maxWidth and height are required so summary box remains on bottom of view
                    .padding()
                    .bold()
            } else {
                // MARK: Shared Productions views
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
        .presentationDetents(viewModel.sharedCredits?.sharedCredits.isEmpty ?? true ? [.height(250)] : [])
    }
}

extension CompareView {
    
    @Observable
    @MainActor
    class CompareViewModel {
        // MARK: ViewModel Properties
        var person1: Person
        var person2: Person
        
        let tmdb = TMDBAPI.shared
        
        var sharedCredits: SharedCreditsContainer? = nil
        
        // MARK: ViewModel Initializers
        init(person1: Person, person2: Person) {
            self.person1 = person1
            self.person2 = person2
            
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
