//
//  CryptoWorldcoinindexModel.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 27.01.2023.
//

import Foundation


struct CryptoWorldcoinindexModel: Codable {
    let markets: [Market]?

    enum CodingKeys: String, CodingKey {
        case markets = "Markets"
    }
}


struct Market: Codable {
    let label: String?
    let name: String?
    let price: Double?
    let volume24H: Double?
    let timestamp: Int?

    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case name = "Name"
        case price = "Price"
        case volume24H = "Volume_24h"
        case timestamp = "Timestamp"
    }
}
