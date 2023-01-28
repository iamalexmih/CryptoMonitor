//
//  Worldcoinindex.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 27.01.2023.
//

import Foundation


class WorldcoinindexAPICaller {
    static let shared = WorldcoinindexAPICaller()
    init() { }
    
    private struct Constants {
        static let httpTicker = "https://www.worldcoinindex.com/apiservice/ticker?key="
        static let httpListMarkets = "https://www.worldcoinindex.com/apiservice/v2getmarkets?key="
        static let fiat = "usd"
    }
    
    private struct CryptoLabel {
        static let btc = "btcbtc"
        static let riple = "rplbtc"
        static let litecoin = "ltcbtc"
        static let eth = "ethbtc"
    }
    
//https://www.worldcoinindex.com/apiservice/ticker?key={key}&label=ethbtc-ltcbtc&fiat=btc
//https://www.worldcoinindex.com/apiservice/ticker?key=rJhQDpvV7zoi74gnEBZ7BTU7Nr8QOUVg5sp&label=ethbtc-ltcbtc&fiat=btc
//https://www.worldcoinindex.com/apiservice/ticker?key=rJhQDpvV7zoi74gnEBZ7BTU7Nr8QOUVg5sp&label=rplbtc-ltcbtc&fiat=usd
    
    
//    https://www.worldcoinindex.com/apiservice/v2getmarkets?key={key}&fiat=btc
//https://www.worldcoinindex.com/apiservice/v2getmarkets?key=rJhQDpvV7zoi74gnEBZ7BTU7Nr8QOUVg5sp&fiat=usd
    
    public func getSelectedCryptoData(completion: @escaping (CryptoWorldcoinindexModel?) -> Void) {
        let urlStr = Constants.httpTicker
        + apiKeyWorldcoinindex
        + "&label="
        + CryptoLabel.eth + "-"
        + CryptoLabel.litecoin
        + "&fiat="
        + Constants.fiat
        
        print("urlStr = \(urlStr)")
        guard let url = URL(string: urlStr) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return print("error URLSession")}
            let cryptos = try? JSONDecoder().decode(CryptoWorldcoinindexModel.self, from: data)
            completion(cryptos)
            
        }
        task.resume()
    }
    
    
    public func getAllCryptoData(completion: @escaping ([Market]?) -> Void) {
        let urlStr = Constants.httpListMarkets
        + apiKeyWorldcoinindex
        + "&fiat="
        + Constants.fiat

        print("urlStr = \(urlStr)")
        guard let url = URL(string: urlStr) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return print("error URLSession")}
            let cryptosList = try? JSONDecoder().decode(CryptoWorldcoinindexModel.self, from: data)
            let cryptos = cryptosList?.markets?.first
            completion(cryptos)
        }
        task.resume()
    }
    
}
