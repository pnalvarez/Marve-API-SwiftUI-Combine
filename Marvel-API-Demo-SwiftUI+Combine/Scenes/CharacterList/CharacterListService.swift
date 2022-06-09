//
//  CharacterListService.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import Foundation
import Combine

protocol CharacterListServiceProtocol {
    func fetchCharacterList(offset: Int, limit: Int) -> AnyPublisher<CharacterListResultModel, APIError>
}

final class CharacterListService: CharacterListServiceProtocol {
    func fetchCharacterList(offset: Int, limit: Int) -> AnyPublisher<CharacterListResultModel, APIError> {
        let endpoint: GeneralCharacterListEndpoint = .getCharacterList(offset: offset,
                                                                       limit: limit)
        return Network<CharacterListResultModel>(endpoint: endpoint).fetchData()
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
