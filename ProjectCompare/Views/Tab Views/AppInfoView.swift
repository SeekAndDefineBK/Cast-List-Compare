//
//  AppInfoView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct AppInfoView: View {
    @StateObject private var viewModel = AppInfoViewModel()
    @AppStorage("titleOnTop") var titleOnTop: Bool = false
    
    // These are setup as User Defaults so it remembers if the user chose to collapse the group after relaunch
    @AppStorage("showingTutorialGroup") var showingTutorialGroup = true
    @AppStorage("showingSettings") var showingSettings = true
    @AppStorage("showingAttribution") var showingAttribution = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("App Info")
                .bold()
                .font(.title)
                .padding()
            
            List {
                Group {
                    DisclosureGroup(isExpanded: $showingSettings) {
                        Toggle(
                            titleOnTop ? "Tab Title on Top" : "Tab Title on Bottom",
                            isOn: $titleOnTop
                        )
                        .padding(.vertical)
                    } label: {
                        Label("Settings", systemImage: "gear")
                            .fontWeight(.medium)
                    }
                    
                    DisclosureGroup(isExpanded: $showingAttribution) {
                        VStack(spacing: 10) {
                            Image("TMDBLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accessibilityHidden(true)
                            
                            Text("""
                            All media-related metadata used in CastList, including actor, director, release dates, and poster art is supplied by The Movie Database (TMDb).
                            
                            CastList uses the TMDb API but is not endorsed or certified by TMDb
                            
                            To add missing films or correct inaccuracies for existing films, please use TMDb’s interface (you’ll need to create an account there too).
                            """)
                            .padding(.vertical)
                        }
                    } label: {
                        Label("Where does this data come from?", systemImage: "arrow.up.arrow.down.circle")
                            .fontWeight(.medium)
                    }
                    
                    DisclosureGroup(isExpanded: $showingTutorialGroup) {
                        Button {
                            viewModel.showingTutorial = true
                        } label: {
                            Text("Open Tutorial")
                                .fontWeight(.medium)
                        }
                        .padding(.vertical)
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 50) // in iOS 16 this adds extra space to the end to prevent the searchbox from overlapping the last item
                        .listRowSeparator(.hidden) // hiding unnecessary separator at the bottom of the screen
                    } label: {
                        Label("What is this app?", systemImage: "questionmark.app")
                            .fontWeight(.medium)
                    }
                    
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .sheet(isPresented: $viewModel.showingTutorial) {
                TutorialView()
            }
     
        }

    }
}

extension AppInfoView {
    class AppInfoViewModel: ObservableObject {
        // MARK: ViewModel Properties
        @Published var showingTutorial = false
        // MARK: ViewModel Initializers
        init() {}
                
        // MARK: ViewModel Methods
        
    }
}
