//
//  APIService.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

import Foundation
import Network

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://api.btcturk.com/api/v2/ticker/currency?symbol=usdt"

    func fetchCoins(completion: @escaping (Result<[CryptoItem], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                }
                return
            }
            
            // response objesini kontrol et
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)))
                }
                return
            }
            
            do {
                // JSON decode işlemi
                let coins = try JSONDecoder().decode([CryptoItem].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(coins))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
