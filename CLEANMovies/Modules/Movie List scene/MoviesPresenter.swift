//
//  MoviesPresenter.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

protocol MoviesPresentationLogic {
    func presentMovieList(_ response: Movies.GetMovieList.Response)
    func presentError(_ error: Error)
}

class MoviesPresenter: MoviesPresentationLogic {

    // MARK: - Properties
    weak var viewController: MoviesDisplayLogic?

    // MARK: Presentation Logic
    func presentMovieList(_ response: Movies.GetMovieList.Response) {
    }

    func presentError(_ error: Error) {
    }
}
