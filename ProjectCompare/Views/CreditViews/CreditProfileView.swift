//
//  CreditProfileView.swift
//  ProjectCompare
//
//  Created by bk on 6/28/24.
//

import SwiftUI
import CachedAsyncImage

struct CreditProfileView: View {
    @StateObject private var viewModel: CreditProfileViewModel
    
    init(credit: SharedCredit) {
        let model = CreditProfileViewModel(credit: credit)
        _viewModel = StateObject(wrappedValue: model)
    }
    
    @ViewBuilder
    func errorImage() -> some View {
        Image(systemName: "movieclapper")
            .resizable()
            .scaledToFit()
    }
    
    var body: some View {
        HStack {
            Group {
                if let url = viewModel.getImageURL() {
                    CachedAsyncImage(url: url.absoluteString) { progress in
                        ProgressView {
                            VStack {
                                Text("Downloading")
                                Text("\(progress)%")
                            }
                            .font(.caption2)
                        }
                    } image: { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } error: { _, _ in
                        errorImage()
                    }
                } else {
                    errorImage()
                }
            }
            .frame(maxWidth: 50)
        }
    }
}

extension CreditProfileView {
    class CreditProfileViewModel: ObservableObject {
        // MARK: ViewModel Properties
        var credit: SharedCredit
        let tmdb = TMDBAPI.shared

        // MARK: ViewModel Initializers
        init(credit: SharedCredit) {
            self.credit = credit
        }
                
        // MARK: ViewModel Methods
        func getImageURL() -> URL? {
            if let posterPath = credit.poster_path {
                return tmdb.getImageURL(with: posterPath)
            } else {
                return nil
            }
        }
    }
}
