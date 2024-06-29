//
//  TMDBAttributionView.swift
//  ProjectCompare
//
//  Created by bk on 6/28/24.
//

import SwiftUI

struct TMDBAttributionView: View {
    
    var body: some View {
        HStack {
            Image("TMDBLogo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30)
            
            Text("Search results provided by The Movie Database")
                .padding(.horizontal)
        }
    }
}
