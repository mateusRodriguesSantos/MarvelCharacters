//
//  MarvelService.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import NetworkCore

protocol MarvelServiceProtocol: NetworkProtocol where T == CharacterDataWrapper {
    
    func fetchCharacter(page: Int, completion: @escaping (Result<[Character], ErrorsRequests>) -> Void)
    func seriesCharacter(completion: @escaping (Result<[SeriesSummary], ErrorsRequests>) -> Void)
    
}

class MarvelService: MarvelServiceProtocol {
    
    func seriesCharacter(completion: @escaping (Result<[SeriesSummary], ErrorsRequests>) -> Void) {
        
    }
    
    func fetchCharacter(page: Int, completion: @escaping (Result<[Character], ErrorsRequests>) -> Void) {
        execute(
            connection: ConnectionMarvel(
                baseURL: "https://gateway.marvel.com:443",
                privateKey: "83335b5b84fcb59e36b6464270c1904947008dcc",
                apiKey: "6ed442aa2c3099ce171f970af141f9b6",
                page: page
            )
        ) { result in
            switch result {
            case .success(let characterData):
                if let list = characterData?.data?.results {
                    completion(.success(list))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
