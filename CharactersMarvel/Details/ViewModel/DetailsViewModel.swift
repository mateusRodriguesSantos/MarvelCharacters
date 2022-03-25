//
//  DetailsViewModel.swift
//  CharactersMarvel
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit
import RxSwift
import RxRelay

class DetailsViewModel {
    
    let service: MarvelService
    var titleName: String
    var imagePerson: UIImage
    var titleParticipations: String
    var participations: [String]
    
    init(service: MarvelService = MarvelService()) {
        self.service = service
        titleName = String()
        imagePerson = UIImage()
        titleParticipations = String()
        participations = []
    }
    
}
