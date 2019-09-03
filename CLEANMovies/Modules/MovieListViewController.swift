//
//  MovieListViewController.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class MovieListViewController: UIViewController {

    // MARK: - Properties
    private let disposeBag = DisposeBag()

    // MARK: - Outlets
    @IBOutlet weak var emptyStateView: UIView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBlueBackground()
        navigationItem.title = "Cartelera"
        loadMovieList()
    }

    // MARK: - Private Methods
    private func loadMovieList() {
        let provider = APIProvider<MoviesAPI>(stub: true)
        provider.rx.request(.moviesList(type: .popular))
            .filterSuccessfulStatusCodes()
            .map(MovieListResponse.self)
            .subscribe(onSuccess: { movies in
                print(movies)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
