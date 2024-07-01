//
//  TutorialView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct TutorialView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = TutorialViewModel()
    
    var body: some View {
        VStack {
            Button {
                dismiss()
            } label: {
                Text("Close")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)

            TabView(selection: $viewModel.selectedTab,
                    content:  {
                TutorialSplashView(
                    continueAction: viewModel.continueToSearch
                )
                    .tag(0)
                
                TutorialSearchView(
                    person1: $viewModel.person1,
                    person2: $viewModel.person2,
                    continueAction: viewModel.comparePeople
                )
                    .tag(1)
                
                TutorialCompareView(
                    person1: $viewModel.person1,
                    person2: $viewModel.person2
                ) {
                    dismiss()
                }
                    .tag(2)
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension TutorialView {
    class TutorialViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var person1: Person?
        @Published var person2: Person?
        @Published var selectedTab = 0
        
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        func continueToSearch() {
            withAnimation {
                selectedTab = 1
            }
        }
        
        func comparePeople() {
            withAnimation {
                selectedTab = 2
            }
        }
    }
}
