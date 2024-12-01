//
//  CryptoListViewController.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

import UIKit

class CryptoListViewController: UIViewController {
    
    private let viewModel = CryptoListViewModel()
    private let tableView = UITableView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
        viewModel.loadCoins()
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        
        // Add constraints for tableView and collectionView
    }
    
    private func setupBindings() {
        viewModel.onCoinsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCoins().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        
        let coin = viewModel.getCoins()[indexPath.row]
        
        // Favori olup olmadığını kontrol et
        let isFavorite = viewModel.favorites.contains(where: { $0.pair == coin.pair })
        
        // Hücreyi yapılandır
        cell.configure(with: coin, isFavorite: isFavorite)
        
        // Favori butonuna basılma aksiyonunu ayarla
        cell.onFavoriteTapped = { [weak self] in
            if isFavorite {
                self?.viewModel.removeFavorite(coin: coin)
            } else {
                self?.viewModel.addFavorite(coin: coin)
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CryptoListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as? FavoriteCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let favoriteCoins = viewModel.favorites[indexPath.item]
        cell.configure(with: favoriteCoins)
        return cell
    }
}
