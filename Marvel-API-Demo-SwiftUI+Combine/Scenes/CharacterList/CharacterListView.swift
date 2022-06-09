//
//  CharacterListView.swift
//  Marvel-API-Demo-SwiftUI+Combine
//
//  Created by Pedro Alvarez on 08/06/22.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        List {
            VStack {
                ForEach(0..<viewModel.totalCharacters, id: \.self) { index in
                    getView(fromIndex: index)
                        .onAppear {
                            viewModel.loadCharacter(index: index)
                        }
                }
            }
        }
        .onAppear {
            viewModel.loadInitialCharacters()
        }
    }
    
    @ViewBuilder
    private func getView(fromIndex index: Int) -> some View {
        if index < viewModel.characterList.count {
            //TO DO
            EmptyView()
        } else {
            ProgressView()
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel())
    }
}
