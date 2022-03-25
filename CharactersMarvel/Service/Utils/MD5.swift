//
//  MD5.swift
//
//
//  Created by Mateus Rodrigues on 23/03/22.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
