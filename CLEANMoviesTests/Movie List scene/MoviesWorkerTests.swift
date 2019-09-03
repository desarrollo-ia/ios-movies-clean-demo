//
//  MoviesWorkerTests.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

@testable import CLEANMovies
import XCTest
import RxSwift

class MoviesWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: MoviesWorker!
    private let disposeBag = DisposeBag()

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMoviesWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMoviesWorker() {
        sut = MoviesWorker()
    }

    // MARK: Tests ********************************************************************************************************

    func testShouldDownloadMovieList() {
        let moviesExpectation = expectation(description: "MovieList")
        var moviesToTest: [Movie]?
        let expectedMovieCount = 20

        sut.getMovieList(type: .popular).subscribe(onSuccess: { movies in
            moviesToTest = movies
            moviesExpectation.fulfill()
        }, onError: { _ in
            XCTFail("Stubbed Request shouldn't fail.")
        }).disposed(by: disposeBag)

        self.waitForExpectations(timeout: 3.0, handler: { error in
            XCTAssertNil(error, "Error en el request")
            XCTAssertNotNil(moviesToTest)
            XCTAssertFalse(moviesToTest!.isEmpty)
            XCTAssertEqual(expectedMovieCount, moviesToTest!.count)
        })
    }
}
