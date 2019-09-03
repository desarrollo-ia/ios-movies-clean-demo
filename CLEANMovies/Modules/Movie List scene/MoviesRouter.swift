//
//  MoviesRouter.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

@objc protocol MoviesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

final class MoviesRouter: NSObject, MoviesRoutingLogic, MoviesDataPassing {

    // MARK: - Properties
    weak var viewController: MoviesViewController?
    var dataStore: MoviesDataStore?

    // MARK: Routing Logic
}

// MARK: - Module Builder
final class MoviesBuilder {

	static func build() -> MoviesViewController {
		let id = String(describing: MoviesViewController.self)
		let viewController = UIStoryboard.movies.instantiateViewController(withIdentifier: id) as! MoviesViewController
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor

        return viewController
	}
}
