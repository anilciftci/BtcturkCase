//
//  BtcTurkDetailPageViewModel.swift.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

import Foundation

class CryptoListViewModel {
    private var allCoins: [CryptoItem] = []
    private(set) var favorites: [CryptoItem] = []
    var onCoinsUpdated: (() -> Void)?
    
    func loadCoins() {
        APIService.shared.fetchCoins { [weak self] result in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
                self?.onCoinsUpdated?()
            case .failure(let error):
                print("Failed to fetch stocks: \(error)")
            }
        }
    }
    
    func addFavorite(coin: CryptoItem) {
        guard !favorites.contains(where: { $0.pair == coin.pair }) else { return }
        favorites.append(coin)
        onCoinsUpdated?()
    }
    
    func removeFavorite(coin: CryptoItem) {
        favorites.removeAll { $0.pair == coin.pair }
        onCoinsUpdated?()
    }
    
    func getCoins() -> [CryptoItem] {
        return allCoins
    }
}
