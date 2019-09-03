//
//  MoviesViewController.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: class {
}

class MoviesViewController: UIViewController {

    // MARK: - Properties
    internal var interactor: (MoviesBusinessLogic & MoviesDataStore)?
    internal var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

    // MARK: - Outlets
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var activityIndicator: IAActivityIndicator!
    @IBOutlet var emptyViews: [UILabel]!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBlueBackground()
        navigationItem.title = "Películas"
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Display Logic Methods
extension MoviesViewController: MoviesDisplayLogic {
}
