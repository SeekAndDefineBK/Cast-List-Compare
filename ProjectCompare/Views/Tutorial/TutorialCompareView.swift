//
//  TutorialCompareView.swift
//  ProjectCompare
//
//  Created by bk on 6/30/24.
//

import SwiftUI

struct TutorialCompareView: View {
//    @StateObject private var viewModel: TutorialCompareViewModel
    @Binding var person1: Person?
    @Binding var person2: Person?
    var completeAction: () -> Void
    
    var body: some View {
        VStack {
            if let person1 = person1, let person2 = person2 {
                Text("And here is your answer!")
                    .font(.title)
                    .bold()
                CompareView(person1: person1, person2: person2)
            } else {
                Text("All people need to be present to compare")
                
                if let person1 = person1 {
                    Text("\(person1.name) is present")
                } else {
                    Text("You need to select the first person on the previous screen.")
                }
                
                if let person2 = person2 {
                    Text("\(person2.name) is present")
                } else {
                    Text("You need to select the second person on the previous screen.")
                }
            }
        }
        
    }
    
    func bothPeoplePresent() -> Bool {
        person1 != nil && person2 != nil
    }
}
