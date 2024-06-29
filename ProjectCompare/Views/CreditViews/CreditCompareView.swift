//
//  CreditCompareView.swift
//  ProjectCompare
//
//  Created by bk on 6/28/24.
//

import SwiftUI

struct CreditCompareView: View {
    @StateObject private var viewModel: CreditCompareViewModel
    
    init(credit: SharedCredit) {
        let model = CreditCompareViewModel(credit: credit)
        _viewModel = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        HStack {
            CreditProfileView(credit: viewModel.credit)
            
            VStack {
                Text(viewModel.credit.title)
                    .bold()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(viewModel.credit.person1.name)
                        Text(viewModel.credit.person1Role)
                            .font(.caption)
                    }
                    // This aligns all uneven person1 placements to leading edge
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.credit.person2.name)
                        Text(viewModel.credit.person2Role)
                            .font(.caption)
                    }
                    // This aligns all uneven person2 placements to leading edge
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                // maxWidth: .infinity... is unnecessary when the two objects inside have this applied
            }
            // this maxWidth: .infinity gives more space to the words than the poster
            .frame(maxWidth: .infinity)
        }
    }
}

extension CreditCompareView {
    class CreditCompareViewModel: ObservableObject {
        // MARK: ViewModel Properties
        var credit: SharedCredit
        let tmdb = TMDBAPI.shared

        // MARK: ViewModel Initializers
        init(credit: SharedCredit) {
            self.credit = credit
        }
                
        // MARK: ViewModel Methods
        
    }
}
