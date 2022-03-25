//
//  ConnectionMarvel.swift
//
//
//  Created by Mateus Rodrigues on 23/03/22.
//

import Foundation
import NetworkCore

internal struct ConnectionMarvel: ConnectionProtocol {
    
    var pageOffset: Int
    var components: [String : String]?
    var headers: [String : String]?
    var baseUrl: URL
    var port: String?
    var router: String
    var method: String?
    var parameters: [String : Any]?
    
    init(baseURL: String, privateKey: String, apiKey: String, page: Int) {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
        pageOffset = page
        headers = [
            "application/json" : "Content-Type"
        ]
        baseUrl = URL(string: baseURL) ?? URL(fileURLWithPath: "")
        port = nil
        router = "v1/public/characters"
        method = nil
        components = [
            "apikey" : apiKey,
            "hash" : hash,
            "ts" : timestamp,
            "limit" : "20",
            "offset" : "\(pageOffset * 20)"
        ]
        parameters = nil
    }
    
}
