//
//  APICaller.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 18.08.2022.
//

import Foundation


final class NomicsAPICaller {
    
    static let shared = NomicsAPICaller()
    
    private struct Constants {
        static let assetsEndpoint = "https://api.nomics.com/v1/currencies/"
        static let interval = "&interval=1d"
        static let currency = "&convert=USD"
    }
    
//https://api.nomics.com/v1/currencies/ticker?key=4c65c458dfd0fadd0f507856e2e73904b307e7a2&ranks=1&interval=1d&convert=USD&per-page=10&page=1
    
//https://api.nomics.com/v1/currenciesticker?key=4c65c458dfd0fadd0f507856e2e73904b307e7a2&ranks=1&interval=1d&convert=USD&per-page=10&page=1
    private init() {
        
    }
    
    public func getAllCryptoData(completion: @escaping ([CryptoNomicModel]?) -> Void) {
        let urlStr = Constants.assetsEndpoint
                        + "ticker?key="
                        + apiKeyNomic
                        + "&ranks=1"
                        + Constants.interval
                        + Constants.currency
                        + "&per-page=10&page=1"
        print("urlStr = \(urlStr)")
        guard let url = URL(string: urlStr) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else { return print("error URLSession")}
            
            let cryptos = try? JSONDecoder().decode([CryptoNomicModel].self, from: data)
            completion(cryptos)
            
        }
        task.resume()
    }
}
