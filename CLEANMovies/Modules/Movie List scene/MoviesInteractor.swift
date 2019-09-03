//
//  MoviesInteractor.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

protocol MoviesBusinessLogic {
}

protocol MoviesDataStore {
    //var myDataStoreVar: String { get set }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {

    // MARK: - Properties
    internal var presenter: MoviesPresentationLogic?
    //private let worker = MoviesWorker()

    // MARK: Business Logic **********************************************************************************************
}
