//
//  AppDelegate.swift
//  CLEANMovies
//
//  Created by Eduardo Pacheco on 9/3/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?

    // MARK: - App Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // App Starting Point
        window = UIWindow(frame: UIScreen.main.bounds)

        //let id = String(describing: MovieListViewController.self)
        //let movieList = UIStoryboard.movies.instantiateViewController(withIdentifier: id)
        let movieList = MoviesBuilder.build()

        let navController = UINavigationController(rootViewController: movieList)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
