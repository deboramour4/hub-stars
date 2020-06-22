//
//  APIRequesterMocl.swift
//  HubStarsTests
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation
@testable import HubStars

final class APIRequesterMock: APIRequesterProtocol {
    func getJSON<T>(endpoint: Endpoint, completion: @escaping ((Result<T, APIRequester.RequestError>) -> Void)) where T: Decodable { }
    
    func getData(endpoint: Endpoint, completion: @escaping ((Result<Data, APIRequester.RequestError>) -> Void)) { }
}
