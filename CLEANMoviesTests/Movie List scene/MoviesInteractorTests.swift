//
//  MoviesInteractorTests.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

@testable import CLEANMovies
import XCTest

class MoviesInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: MoviesInteractor!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMoviesInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMoviesInteractor() {
        sut = MoviesInteractor()
    }

    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Espera")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }

    // MARK: Test doubles
    class FakeMovieListPresenter: MoviesPresentationLogic {
        var didPresentMovieList = false
        var didPresentError = false

        func presentMovieList(_ response: Movies.GetMovieList.Response) {
            didPresentMovieList = true
            didPresentError = false
        }

        func presentError(_ error: Error) {
            didPresentMovieList = false
            didPresentError = true
        }
    }

    // MARK: Tests ***************************************************************************************************

    func testInteractorShouldPresentMovieListResults() {
        let fakePresenter = FakeMovieListPresenter()
        sut.presenter = fakePresenter

        let request = Movies.GetMovieList.Request(listType: .popular)
        sut.requestMovieList(request)
        wait(for: 3.0)

        XCTAssertTrue(fakePresenter.didPresentMovieList)
        XCTAssertFalse(fakePresenter.didPresentError)
        XCTAssertFalse(sut.moviesArray.isEmpty)
    }
}
