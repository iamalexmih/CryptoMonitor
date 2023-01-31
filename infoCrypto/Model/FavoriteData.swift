//
//  FavoriteData.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 30.01.2023.
//

import Foundation


class FavoriteData {
    static let shared = FavoriteData()
    
    private init() { }
    
    var favoriteList: [String] = []
}
