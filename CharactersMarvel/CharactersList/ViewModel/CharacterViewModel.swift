//
//  CharactersListViewModel.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit
import RxSwift
import RxRelay

class CharactersListViewModel {
    
    let service: MarvelService
    var pageList: Int
    var displayTitle: String
    var listChars: [Character]
    var listCharsRelay: BehaviorRelay<[Character]>
    
    init(service: MarvelService = MarvelService()) {
        self.service = service
        pageList = 0
        displayTitle = "Marvel Characters"
        listChars = []
        listCharsRelay = BehaviorRelay(value: listChars)
    }
    
    func fechCharacters(page: Int) {
        service.fetchCharacter(page: page) { [weak self] result in
            switch result {
            case .success(let list):
                let value = self?.listCharsRelay.value ?? []
                self?.listCharsRelay.accept(value + list)
            case .failure(_):
                self?.listCharsRelay.accept([])
            }
        }
    }
    
    func checkEndList(_ lastIndex: Int) {
        let value = listCharsRelay.value
        if lastIndex == value.count - 1 {
            pageList += 1
            fechCharacters(page: pageList + 1)
        }
    }
}
