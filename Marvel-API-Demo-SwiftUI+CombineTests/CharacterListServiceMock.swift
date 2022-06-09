//
//  CharacterListServiceMock.swift
//  Marvel-API-Demo-SwiftUI+CombineTests
//
//  Created by Pedro Alvarez on 08/06/22.
//

@testable import Marvel_API_Demo_SwiftUI_Combine
import Combine

final class CharacterListServiceMock: CharacterListServiceProtocol {
    private let error: APIError?
    
    init(error: APIError? = nil) {
        self.error = error
    }
    
    func fetchCharacterList(offset: Int, limit: Int) -> AnyPublisher<CharacterListResultModel, APIError> {
        Future<CharacterListResultModel, APIError> { promise in
            guard let error = self.error else {
                promise(.success(CharacterListResultModel(data: CharactersListModel(total: 1,
                                                                                    results: [CharacterModel(id: 0,
                                                                                                                       name: "Character", description: "Description",
                                                                                                                       thumbnail: ThumbnailModel(path: "path",
                                                                                                                                                 imageExtension: "jpg"))]))))
                return
            }
            promise(.failure(error))
        }
        .eraseToAnyPublisher()
    }
}
