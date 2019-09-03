//
//  MoviesWorker.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

import Moya
import RxSwift

class MoviesWorker {

    // MARK: - Properties
    let provider = APIProvider<MoviesAPI>(stub: true)

    // MARK: - Public Methods
    func getMovieList(type: MovieListType) -> Single<[Movie]> {
        let request = provider.rx.request(.moviesList(type: .popular))
            .filterSuccessfulStatusCodes()
            .map(MovieListResponse.self)
            .map({ $0.movieList })

        return request
    }
}
