//
//  CryptoModel.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 18.08.2022.
//

import Foundation


struct CryptoModel: Codable {
    let id: String
    let currency: String
    let symbol: String
    let name: String
    let price: String
}
