//
//  PersonProfileView.swift
//  ProjectCompare
//
//  Created by bk on 6/28/24.
//

import SwiftUI
import CachedAsyncImage

struct PersonProfileView: View {
    @StateObject private var viewModel: PersonProfileViewModel
    
    init(person: Person) {
        let model = PersonProfileViewModel(person: person)
        _viewModel = StateObject(wrappedValue: model)
    }
    
    @ViewBuilder
    func errorImage() -> some View {
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFill()
    }
    
    var body: some View {
        HStack {
            Group {
                if let url = viewModel.getImageURL() {
                    CachedAsyncImage(url: url.absoluteString) { progress in
                        ProgressView {
                            VStack {
                                Text("Downloading...")
                                Text("\(progress)%")
                            }
                            .font(.caption2)
                        }
                    } image: { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } error: { _, _ in
                        errorImage()
                    }

                } else {
                    errorImage()
                }
            }
            .frame(maxWidth: 50, maxHeight: 50)
            
            Text(viewModel.person.name)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension PersonProfileView {
    class PersonProfileViewModel: ObservableObject {
        // MARK: ViewModel Properties
        let person: Person
        let tmdb = TMDBAPI.shared
        
        // MARK: ViewModel Initializers
        init(person: Person) {
            self.person = person
        }
                
        // MARK: ViewModel Methods
        func getImageURL() -> URL? {
            if let profilePath = person.profile_path {
                return tmdb.getImageURL(with: person.profile_path ?? "")
            } else {
                return nil
            }
            
        }
    }
}
