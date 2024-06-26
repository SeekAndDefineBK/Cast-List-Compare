//
//  Person.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

@Observable
class Person: Identifiable, Hashable, Equatable, Codable {
    var id: Int
    var name: String
    var popularity: Double
    
    // MARK: Profile Image
    // This is optional because sometimes the Person doesn't have an image associated
    var profile_path: String?
    
    init(
        id: Int,
        name: String,
        popularity: Double,
        profile_path: String? = nil
    ) {
        self.id = id
        self.name = name
        self.popularity = popularity
        self.profile_path = profile_path
    }
    
    // Equatable conformance
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
    
    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: Codable Conformance
    enum CodingKeys: CodingKey {
            case id, name, popularity, profile_path
        }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        popularity = try container.decode(Double.self, forKey: .popularity)
        profile_path = try container.decode(String?.self, forKey: .profile_path)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(profile_path, forKey: .profile_path)
    }
}
