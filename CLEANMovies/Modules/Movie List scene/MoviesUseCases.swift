//
//  MoviesUseCases.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

import Foundation

// MARK: - Module Error Types
enum MovieListError: Error {
    case networkError
    case unknown
}

// MARK: - Module use cases
enum Movies {

    enum GetMovieList {

        struct Request {
            let listType: MovieListType
        }

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let movieCells: [MovieCellViewModel]
        }

        // MARK: - Internal Types
        struct MovieCellViewModel {
            let posterURL: URL?
            let titleLabel: String
            let dateLabel: String
            let scoreLabel: String
        }
    }
}
