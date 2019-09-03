//
//  MoviesAPI.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import Foundation
import Alamofire
import Moya

// MARK: - Movie List Type
enum MovieListType: String {
    case nowPlaying = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
}

// MARK: - API Endpoints enumeration
enum MoviesAPI {

    case moviesList(type: MovieListType)
}

// MARK: - Extension
extension MoviesAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }

    var path: String {
        switch self {

        case .moviesList(let type):
            return "movie/\(type.rawValue)"
        }
    }

    var method: Moya.Method {
        switch self {

        default:
            return .get
        }
    }

    var sampleData: Data {
        switch self {

        case .moviesList:
            return stubbedResponse("movieList")
        }
    }

    var task: Task {
        let baseParams: [String: Any] = [
            "api_key": "---" // Insert your own API key here to use real network responses.
            //"language": "es-MX",
            //"region": "MX"
        ]

        switch self {

        case .moviesList:
            return .requestParameters(parameters: baseParams, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }

    // MARK: - Private Methods *************************************************************************************

    private func stubbedResponse(_ filename: String) -> Data! {
        class DummyClass {}
        let bundle = Bundle(for: DummyClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}

// MARK: - API Provider extension
class APIProvider<T>: MoyaProvider<T> where T: TargetType {

    internal var customManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]

        // Set custom timeout for requests
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60

        let manager = Alamofire.SessionManager(configuration: configuration,
                                               serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))

        return manager
    }()

    init(stub: Bool = false) {
        let stubClosure: MoyaProvider<T>.StubClosure = stub ? MoyaProvider.delayedStub(2) : MoyaProvider.neverStub
        super.init(stubClosure: stubClosure, manager: self.customManager)
    }
}
