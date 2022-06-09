//
//  CharacterListViewModel.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
    private let service: CharacterListServiceProtocol
    
    @Published private(set) var characterList: [CharacterModel] = []
    @Published private(set) var totalCharacters: Int = 0
    @Published private(set) var hasError: Bool = false
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var currentOffset: Int = 0
    
    init(service: CharacterListServiceProtocol = CharacterListService()) {
        self.service = service
    }
    
    func loadInitialCharacters() {
        service.fetchCharacterList(offset: currentOffset,
                                   limit: Constants.pageSize)
        .map({ $0.data })
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                self.hasError = false
            case .failure(_):
                self.hasError = true
            }
        }, receiveValue: { value in
            self.currentOffset += Constants.pageSize - 1
            self.characterList.append(contentsOf: value.results)
            self.totalCharacters = value.total
        })
        .store(in: &cancellables)
    }
    
    func loadCharacter(index: Int) {
        guard index > currentOffset else {
            return
        }
        currentOffset += Constants.pageSize
        service.fetchCharacterList(offset: currentOffset,
                                   limit: Constants.pageSize)
        .map({ $0.data })
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                self.hasError = false
            case .failure(_):
                self.hasError = true
            }
        }, receiveValue: { value in
            self.characterList.append(contentsOf: value.results)
            self.totalCharacters = value.total
        })
        .store(in: &cancellables)
    }
}
