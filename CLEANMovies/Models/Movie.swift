//
//  Movie.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import Foundation

struct Movie: Codable {

    // MARK: - Properties
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
    let releaseDateString: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDateString = "release_date"
    }
}
