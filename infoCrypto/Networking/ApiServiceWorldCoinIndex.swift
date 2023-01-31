//
//  Worldcoinindex.swift
//  infoCrypto
//
//  Created by Алексей Попроцкий on 27.01.2023.
//

import Foundation


class ApiServiceWorldCoinIndex: ApiServiceProtocol {
    
    static let shared = ApiServiceWorldCoinIndex()
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
    
    func fetchSelectedCrypto(completion: @escaping (Result<[Market]?, Error>) -> Void) {
        let urlStr = Constants.httpTicker
        + apiKeyWorldcoinindex
        + "&label="
        + CryptoLabel.eth + "-"
        + CryptoLabel.litecoin
        + "&fiat="
        + Constants.fiat
                
        guard let url = URL(string: urlStr) else {
            let error = ApiError.badUrl
            completion(Result.failure(error))
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(Result.failure(ApiError.url(error as? URLError)))
            } else  if let data = data {
                let decoder = JSONDecoder()
                do {
                    let selectedCrypto = try decoder.decode(SelectedCryptoWorldCoinIndexModel.self, from: data)
                    let cryptosList = selectedCrypto.markets
                    
                    completion(Result.success(cryptosList))
                } catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError )))
                }
            }
        }
        task.resume()
    }
    
    
    func fetchAllCrypto(completion: @escaping (Result<[Market]?, Error>) -> Void) {
        let urlStr = Constants.httpListMarkets
        + apiKeyWorldcoinindex
        + "&fiat="
        + Constants.fiat

        print("urlStr = \(urlStr)")
        
        guard let url = URL(string: urlStr) else {
            let error = ApiError.badUrl
            completion(Result.failure(error))
            return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(Result.failure(ApiError.url(error as? URLError)))
            } else  if let data = data {
                let decoder = JSONDecoder()
                do {
                    let cryptosList = try decoder.decode(CryptoWorldCoinIndexModel.self, from: data)
                    let cryptos = cryptosList.markets?.first
                        completion(Result.success(cryptos))
                } catch {
                    completion(Result.failure(ApiError.parsing(error as? DecodingError )))
                }
            }
        }
        task.resume()
    }
    
}
