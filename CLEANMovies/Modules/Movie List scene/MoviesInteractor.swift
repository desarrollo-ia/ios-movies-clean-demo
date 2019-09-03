//
//  MoviesInteractor.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

import RxSwift

protocol MoviesBusinessLogic {
    func requestMovieList(_ request: Movies.GetMovieList.Request)
}

protocol MoviesDataStore {
    var moviesArray: [Movie] { get }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {

    // MARK: - Properties
    internal var presenter: MoviesPresentationLogic?
    internal var moviesArray = [Movie]()
    private let worker = MoviesWorker()
    private let disposeBag = DisposeBag()

    // MARK: Business Logic *****************************************************************************************

    func requestMovieList(_ request: Movies.GetMovieList.Request) {
        worker.getMovieList(type: request.listType).subscribe(onSuccess: { [weak self] movies in
            self?.moviesArray = movies
            let response = Movies.GetMovieList.Response(movies: movies)
            self?.presenter?.presentMovieList(response)
        }, onError: { [weak self] error in
            self?.presenter?.presentError(error)
        }).disposed(by: disposeBag)
    }
}
