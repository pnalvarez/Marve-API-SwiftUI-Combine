//
//  CharacterListViewModelTests.swift
//  Marvel-API-Demo-SwiftUI+CombineTests
//
//  Created by Pedro Alvarez on 08/06/22.
//

import XCTest
@testable import Marvel_API_Demo_SwiftUI_Combine

class CharacterListViewModelTests: XCTestCase {
    
    var sut: CharacterListViewModel?
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLoadInitialCharacters_Success() {
        let mock = CharacterListServiceMock()
        let expected =  [CharacterModel(id: 0,
                                        name: "Character", description: "Description",
                                        thumbnail: ThumbnailModel(path: "path",
                                                                  imageExtension: "jpg"))]
        sut = CharacterListViewModel(service: mock)
        sut?.loadInitialCharacters()
        XCTAssertEqual(sut?.characterList, expected)
        XCTAssertEqual(sut?.totalCharacters, 1)
    }
    
    func testLoadInitialCharacters_Error() {
        let mock = CharacterListServiceMock(error: .generic)
        sut = CharacterListViewModel(service: mock)
        sut?.loadInitialCharacters()
        XCTAssertTrue(sut?.hasError ?? false)
    }
    
    func testLoadCharacters_Success() {
        let mock = CharacterListServiceMock()
        sut = CharacterListViewModel(service: mock)
        sut?.loadInitialCharacters()
        sut?.loadCharacter(index: 10)
        let expected = [CharacterModel(id: 0,
                                       name: "Character", description: "Description",
                                       thumbnail: ThumbnailModel(path: "path",
                                                                 imageExtension: "jpg")), CharacterModel(id: 0,
                                                                                                         name: "Character", description: "Description",
                                                                                                         thumbnail: ThumbnailModel(path: "path",
                                                                                                                                   imageExtension: "jpg"))]
        XCTAssertEqual(sut?.totalCharacters, 1)
        XCTAssertEqual(sut?.characterList, expected)
    }
    
    func testLoadCharacters_Error() {
        let mock = CharacterListServiceMock(error: .generic)
        sut = CharacterListViewModel(service: mock)
        sut?.loadInitialCharacters()
        sut?.loadCharacter(index: 10)
        XCTAssertTrue(sut?.hasError ?? false)
    }
    
    func testLoadCharacters_Nothing() {
        let mock = CharacterListServiceMock()
        sut = CharacterListViewModel(service: mock)
        sut?.loadInitialCharacters()
        sut?.loadCharacter(index: 5)
        let expected =  [CharacterModel(id: 0,
                                        name: "Character", description: "Description",
                                        thumbnail: ThumbnailModel(path: "path",
                                                                  imageExtension: "jpg"))]
        XCTAssertEqual(sut?.totalCharacters, 1)
        XCTAssertEqual(sut?.characterList, expected)
    }
}
