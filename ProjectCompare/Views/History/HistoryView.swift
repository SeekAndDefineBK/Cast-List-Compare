//
//  HistoryView.swift
//  ProjectCompare
//
//  Created by Brett Koster on 11/17/24.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...10, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Person 1")
                        
                            Spacer()
                            
                            Text("Person 2")
                        }
                        
                        Text("Appears in \(index) titles together.")
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}


#Preview {
    HistoryView()
}
