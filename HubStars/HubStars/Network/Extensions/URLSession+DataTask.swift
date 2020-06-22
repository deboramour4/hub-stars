//
//  GitHubService.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Extension URLSession
extension URLSession {
    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(HTTPURLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                result(.failure(APIRequester.RequestError.emptyData))
                return
            }
            result(.success((httpResponse, data)))
        }
    }
}
