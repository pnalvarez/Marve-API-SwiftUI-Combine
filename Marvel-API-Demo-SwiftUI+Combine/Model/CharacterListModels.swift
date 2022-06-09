//
//  CharacterListModels.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

struct CharactersListModel: Decodable, Equatable {
    let total: Int
    let results: [CharacterModel]
}

struct CharacterListResultModel: Decodable, Equatable {
    let data: CharactersListModel
}

struct CharacterModel: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailModel
}

struct ThumbnailModel: Decodable, Equatable {
    let path: String
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

