//
//  Network.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import Foundation
import Combine

protocol NetworkProtocol {
    associatedtype T: Decodable
    func fetchData() -> AnyPublisher<T, APIError>
}

enum APIError: Error {
    case invalidURL
    case fetchData
    case generic
    case decode
}

final class Network<T: Decodable> {
    private let endpoint: APIEndpointExposable
    
    private var cancellable: AnyCancellable?
    private let basePath = "https://gateway.marvel.com/v1/public"
    private let apiKey = "5d270d6ba90b8e7de71d2a65b6cce967&hash=1eb2d8a190e62c0ecf934462a91eb071"
    
    init(endpoint: APIEndpointExposable) {
        self.endpoint = endpoint
    }
    
    private func makeExtraHeaders() -> String? {
        var headerString = ""
        guard let headers = endpoint.headers else {
            return nil
        }
        for (key, value) in headers {
            headerString += "&\(key)=\(value)"
        }
        return headerString
    }
}

extension Network: NetworkProtocol {
    func fetchData() -> AnyPublisher<T, APIError> {
        return Deferred {
            Future<T, APIError> { promise in
                let baseURL = self.basePath + self.endpoint.path + "?ts=1&apikey=\(self.apiKey)" + (self.makeExtraHeaders() ?? "")
                guard let url = URL(string: baseURL) else {
                    promise(.failure(.invalidURL))
                    return
                }
                var requestModel = URLRequest(url: url)
                requestModel.httpMethod = self.endpoint.method.rawValue
                requestModel.httpBody = self.endpoint.body
                self.cancellable = URLSession.shared.dataTaskPublisher(for: requestModel)
                    .map({ $0.data })
                    .decode(type: T.self, decoder: JSONDecoder())
                    .sink(receiveCompletion: { result in
                        switch result {
                        case .finished:
                            break
                        case let .failure(error):
                            if let _ = error as? DecodingError {
                                promise(.failure(.decode))
                            } else {
                                promise(.failure(.generic))
                            }
                        }
                    }, receiveValue: { value in
                        promise(.success(value))
                    })
                
            }
        }.eraseToAnyPublisher()
    }
}
