//
//  FavoriteCryptoStorageManager.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 31.01.2023.
//

import Foundation


class FavoriteCryptoStorageManager {
        
    static let shared = FavoriteCryptoStorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "FavoriteCrypto"
    
    private init() {}
    
    
    func save(favoriteList: [String]) {
        userDefaults.set(favoriteList, forKey: key)
    }
    
    
    func load() -> [String] {
        return userDefaults.stringArray(forKey: key) ?? []
    }
    
    
    func clear(favoriteList: [String]) {
        userDefaults.removeObject(forKey: key)
    }
}
