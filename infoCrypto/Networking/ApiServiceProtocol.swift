//
//  ApiServiceProtocol.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 28.01.2023.
//

import Foundation


protocol ApiServiceProtocol {
    
    func fetchAllCrypto(completion: @escaping(Result<[Market]?, Error>) -> Void)
    func fetchSelectedCrypto(completion: @escaping(Result<[Market]?, Error>) -> Void)
    
}
