//
//  Array.swift
//  ProjectCompare
//
//  Created by bk on 6/27/24.
//

import Foundation

//https://www.hackingwithswift.com/example-code/language/how-to-find-the-difference-between-two-arrays
extension Array where Element: Hashable {
    /// This will compare self (an array) to another array, and return a new array with only the elements in common.
    /// - Parameter other: An array of Hashable objects
    /// - Returns: A new array of elements both arrays have in common.
    func intersection(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.intersection(otherSet))
    }
}
