//
//  MoviesViewController.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright (c) 2019 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

protocol MoviesDisplayLogic: class {
    func displayMoviesList(_ viewModel: Movies.GetMovieList.ViewModel)
    func displayEmptyState()
    func displayErrorAlert(message: String)
}

class MoviesViewController: UIViewController {

    // MARK: - Properties
    internal var interactor: (MoviesBusinessLogic & MoviesDataStore)?
    internal var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    private var movieCells = [Movies.GetMovieList.MovieCellViewModel]()

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
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.toggleActivityIndicator()
            let request = Movies.GetMovieList.Request(listType: .popular)
            self.interactor?.requestMovieList(request)
        })
    }

    private func toggleActivityIndicator() {
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
            emptyViews.forEach({ $0.isHidden = false })
        } else {
            emptyViews.forEach({ $0.isHidden = true })
            activityIndicator.startAnimating()
        }
    }
}

// MARK: - Display Logic Methods
extension MoviesViewController: MoviesDisplayLogic {

    func displayMoviesList(_ viewModel: Movies.GetMovieList.ViewModel) {
        emptyStateView.isHidden = true
        movieCells = viewModel.movieCells
        tableView.isHidden = false
        tableView.reloadSections([0], with: .fade)
        toggleActivityIndicator()
    }

    func displayEmptyState() {
        toggleActivityIndicator()
    }

    func displayErrorAlert(message: String) {
        toggleActivityIndicator()
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table View Methods
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        cell.setupCell(withModel: movieCells[indexPath.row])
        return cell
    }
}
