//
//  APIEndpointExposable.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import Foundation

protocol APIEndpointExposable {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String : String]? { get }
    var body: Data? { get }
}
