//
//  TutorialSplashView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct TutorialSplashView: View {
    @StateObject private var viewModel = TutorialSplashViewModel()
    var continueAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("AbstractIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 2, x: 2, y: 2)
                .padding()
                .accessibilityHidden(true)
            
            Text("Hello! This is CastList")
                .font(.largeTitle)
                .bold()
            
            Text("""
                An app to help you answer the question: *How many movies have these two been in?*
                
                Tap continue to see how!
                """
                )
            
            Spacer()
            
            Button {
                continueAction()
            } label: {
                Text("Continue")
            }
        }
        .padding()
    }
}

extension TutorialSplashView {
    class TutorialSplashViewModel: ObservableObject {
        // MARK: ViewModel Properties

        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
