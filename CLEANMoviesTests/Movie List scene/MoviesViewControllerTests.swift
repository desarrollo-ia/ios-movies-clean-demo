//
//  MoviesViewControllerTests.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

@testable import CLEANMovies
import XCTest

class MoviesViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: MoviesViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMoviesViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupMoviesViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Movies", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
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
    class FakeMovieListInteractor: MoviesBusinessLogic, MoviesDataStore {
        var moviesArray = [Movie]()
        var didRequestedMovieList = false

        func requestMovieList(_ request: Movies.GetMovieList.Request) {
            didRequestedMovieList = true
        }
    }

    // MARK: Tests ****************************************************************************************************

    func testShouldRequestMovieListOnViewDidLoad() {
        let fakeInteractor = FakeMovieListInteractor()
        sut.interactor = fakeInteractor
        loadView()
        wait(for: 2.0)

        XCTAssertTrue(fakeInteractor.didRequestedMovieList)
    }

    func testShouldDisplayMovieList() {
        let stubbedCell = Movies.GetMovieList.MovieCellViewModel(
            posterURL: nil,
            titleLabel: "TEST",
            dateLabel: "TEST",
            scoreLabel: "TEST"
        )
        let viewModel = Movies.GetMovieList.ViewModel(movieCells: [stubbedCell])
        loadView()
        wait(for: 2.0)
        sut.displayMoviesList(viewModel)

        XCTAssertFalse(sut.activityIndicator.isAnimating)
        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)
        XCTAssertFalse(sut.tableView.isHidden)
        XCTAssertTrue(sut.emptyStateView.isHidden)
    }

    func testShouldDisplayEmptyState() {
        loadView()
        wait(for: 2.0)
        sut.displayEmptyState()

        XCTAssertFalse(sut.activityIndicator.isAnimating)
        XCTAssertTrue(sut.tableView.visibleCells.isEmpty)
        XCTAssertTrue(sut.tableView.isHidden)
        XCTAssertFalse(sut.emptyStateView.isHidden)
    }

    func testShouldDisplayErrorAlert() {
        loadView()
        wait(for: 2.0)
        sut.displayErrorAlert(message: "TEST")

        XCTAssertFalse(sut.activityIndicator.isAnimating)
        XCTAssertTrue(sut.tableView.visibleCells.isEmpty)
        XCTAssertTrue(sut.tableView.isHidden)
        XCTAssertFalse(sut.emptyStateView.isHidden)
        XCTAssertFalse(sut.view.isFocused) // The view is not focused because of the alert view controller presented.
    }
}
