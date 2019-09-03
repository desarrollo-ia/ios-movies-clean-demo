//
//  MoviesPresenter.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

import Foundation

protocol MoviesPresentationLogic {
    func presentMovieList(_ response: Movies.GetMovieList.Response)
    func presentError(_ error: Error)
}

class MoviesPresenter: MoviesPresentationLogic {

    // MARK: - Properties
    internal weak var viewController: MoviesDisplayLogic?
    private var dateFormatter = DateFormatter()
    private let resourceURLBase = "https://image.tmdb.org/t/p/w500"

    // MARK: Presentation Logic *************************************************************************************

    func presentMovieList(_ response: Movies.GetMovieList.Response) {
        var movieCells = [Movies.GetMovieList.MovieCellViewModel]()

        for movie in response.movies {
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let movieDate = dateFormatter.date(from: movie.releaseDateString) ?? Date()
            dateFormatter.dateStyle = .medium
            let cell = Movies.GetMovieList.MovieCellViewModel(
                posterURL: URL(string: resourceURLBase + movie.posterPath),
                titleLabel: movie.title,
                dateLabel: dateFormatter.string(from: movieDate),
                scoreLabel: "⭐️ \(movie.voteAverage)"
            )
            movieCells.append(cell)
        }

        if movieCells.isEmpty {
            viewController?.displayEmptyState()
        } else {
            let viewModel = Movies.GetMovieList.ViewModel(movieCells: movieCells)
            viewController?.displayMoviesList(viewModel)
        }
    }

    func presentError(_ error: Error) {
        var errorMessage: String!
        if let err = error as? MovieListError {
            switch err {
            case .networkError:
                errorMessage = "Error de conexión. Vuelve a intentarlo"
            case .unknown:
                errorMessage = "Ha ocurrido un error. Vuelve a intentarlo"
            }
        } else {
            errorMessage = error.localizedDescription
        }
        viewController?.displayErrorAlert(message: errorMessage)
    }
}
