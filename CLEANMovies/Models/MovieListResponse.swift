//
//  MovieListResponse.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import Foundation

struct MovieListResponse: Codable {

    // MARK: - Properties
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let movieList: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movieList = "results"
    }
}
