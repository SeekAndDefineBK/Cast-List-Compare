//
//  Movie.swift
//  ProjectCompare
//
//  Created by Brett Koster on 6/25/24.
//

import Foundation

/// TMBD returns credits split by Cast and Crew and contains the ID of
/// the person who the credits relate to.
/// Use this to decode the CombinedCredit results
struct CombinedCreditsJSON: Codable {
    var id: Int
    var cast: [CombinedCredits]
    var crew: [CombinedCredits]
}

/// CombinedCredits are a type of credit that could be either Cast or Crew
/// This is a Credit for a specific person which relates to their role in
/// a Movie or TV show
class CombinedCredits: Identifiable, Hashable, Codable {
    // MARK: Cast and Crew, Movie and TV Show properties
    var id: Int
    private var media_type: String
    var mediaType: MediaType {
        MediaType(rawValue: media_type) ?? .unknown
    }
    var poster_path: String?
    
    // MARK: Cast only properties
    var character: String?
    
    // MARK: Crew only properties
    var department: String?
    var job: String?
    
    // MARK: Movie Properties
    var title: String?
    private var release_date: String?

    // MARK: TV Show Properties
    var name: String?
    private var first_air_date: String?
    
    // This comes from TMDB as raw date string
    // MARK: Convenience Date Properties
    var releaseDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let unwrappedDate = release_date {
            let date = formatter.date(from: unwrappedDate)
            return date
        } else {
            return nil
        }
    }
    
    var formattedReleaseDateString: String {
        return releaseDate?.formatted(date: .long, time: .omitted) ?? "Unknown"
    }
    
    var firstAirDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let unwrappedDate = first_air_date {
            let date = formatter.date(from: unwrappedDate)
            return date
        } else {
            return nil
        }
    }
    
    var formattedfirstAirDate: String {
        return firstAirDate?.formatted(date: .long, time: .omitted) ?? "Unknown"
    }
    
    // MARK: Equatable Conformance
    static func == (lhs: CombinedCredits, rhs: CombinedCredits) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: Codable Conformance
    enum CodingKeys: CodingKey {
        case id, title, poster_path, release_date, character, department, job, media_type, name, first_air_date
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        poster_path = try? container.decode(String.self, forKey: .poster_path)
        release_date = try? container.decode(String.self, forKey: .release_date)
        character = try? container.decode(String.self, forKey: .character)
        department = try? container.decode(String.self, forKey: .department)
        job = try? container.decode(String.self, forKey: .job)
        media_type = try container.decode(String.self, forKey: .media_type)
        name = try? container.decode(String.self, forKey: .name)
        first_air_date = try? container.decode(String.self, forKey: .first_air_date)
    }
}
