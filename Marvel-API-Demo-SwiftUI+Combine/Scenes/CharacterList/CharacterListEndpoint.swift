//
//  CharacterListEndpoint.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import Foundation

enum GeneralCharacterListEndpoint: APIEndpointExposable {
    case getCharacterList(offset: Int, limit: Int)
    
    var path: String {
        switch self {
        case .getCharacterList:
            return "/characters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacterList:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .getCharacterList(offset, limit):
            return ["offset": "\(offset)",
                    "limit": "\(limit)"]
        }
    }
    
    var body: Data? {
        switch self {
        case .getCharacterList:
            return nil
        }
    }
}
