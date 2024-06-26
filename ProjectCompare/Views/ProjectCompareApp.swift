//
//  ProjectCompareApp.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import SwiftUI

@main
struct ProjectCompareApp: App {
    @State private var tmdb = TMDBAPI()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(tmdb)
        }
    }
}
