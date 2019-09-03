//
//  MoviesPresenterTests.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

@testable import CLEANMovies
import XCTest

class MoviesPresenterTests: XCTestCase {

    // MARK: Subject under test
    var sut: MoviesPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMoviesPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMoviesPresenter() {
        sut = MoviesPresenter()
    }

    // MARK: Test doubles
    class FakeMoviesViewController: MoviesDisplayLogic {
        var movieCells = [Movies.GetMovieList.MovieCellViewModel]()
        var didDisplayedMovieList = false
        var didDisplayedEmptyState = false
        var didDisplayedError = false

        func displayMoviesList(_ viewModel: Movies.GetMovieList.ViewModel) {
            didDisplayedMovieList = true
            movieCells = viewModel.movieCells
        }

        func displayEmptyState() {
            didDisplayedEmptyState = true
        }

        func displayErrorAlert(message: String) {
            didDisplayedError = true
        }

    }

    // MARK: Tests ***************************************************************************************************

    func testPresenterShouldDisplayedMovieList() {
        let fakeVC = FakeMoviesViewController()
        sut.viewController = fakeVC

        let stubbedMovie = Movie(
            id: -999,
            title: "TEST",
            originalTitle: "TEST",
            overview: "TEST",
            posterPath: "TEST",
            backdropPath: "TEST",
            voteAverage: 8.0,
            releaseDateString: "1988-04-28"
        )
        let response = Movies.GetMovieList.Response(movies: [stubbedMovie])
        sut.presentMovieList(response)

        XCTAssertTrue(fakeVC.didDisplayedMovieList)
        XCTAssertFalse(fakeVC.didDisplayedEmptyState)
        XCTAssertFalse(fakeVC.didDisplayedError)
        XCTAssertFalse(fakeVC.movieCells.isEmpty)
    }

    func testPresenterShouldDisplayEmptyState() {
        let fakeVC = FakeMoviesViewController()
        sut.viewController = fakeVC

        let response = Movies.GetMovieList.Response(movies: [Movie]())
        sut.presentMovieList(response)

        XCTAssertFalse(fakeVC.didDisplayedMovieList)
        XCTAssertTrue(fakeVC.didDisplayedEmptyState)
        XCTAssertFalse(fakeVC.didDisplayedError)
        XCTAssertTrue(fakeVC.movieCells.isEmpty)
    }

    func testPresenterShouldDisplayError() {
        let fakeVC = FakeMoviesViewController()
        sut.viewController = fakeVC
        sut.presentError(MovieListError.networkError)

        XCTAssertFalse(fakeVC.didDisplayedMovieList)
        XCTAssertFalse(fakeVC.didDisplayedEmptyState)
        XCTAssertTrue(fakeVC.didDisplayedError)
        XCTAssertTrue(fakeVC.movieCells.isEmpty)
    }
}
