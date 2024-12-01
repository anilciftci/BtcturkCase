//
//  CrptoTableViewCell.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

import Foundation
import UIKit
class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    // MARK: - UI Elements
     private let favoriteButton: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(systemName: "star"), for: .normal) // Boş yıldız
         button.setImage(UIImage(systemName: "star.fill"), for: .selected) // Dolu yıldız
         button.tintColor = .yellow
         return button
     }()
     
     private let pairNameLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.boldSystemFont(ofSize: 16)
         label.textColor = .white
         return label
     }()
     
     private let lastPriceLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textColor = .white
         return label
     }()
     
     private let dailyPercentLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 14)
         label.textAlignment = .right
         label.layer.cornerRadius = 4
         label.clipsToBounds = true
         label.textColor = .white
         return label
     }()
     
     private let volumeLabel: UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 12)
         label.textColor = .lightGray
         return label
     }()
     
     var onFavoriteTapped: (() -> Void)?
     
     // MARK: - Init
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         backgroundColor = .clear
         selectionStyle = .none
         setupViews()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     // MARK: - Setup Views
     private func setupViews() {
         addSubview(favoriteButton)
         addSubview(pairNameLabel)
         addSubview(lastPriceLabel)
         addSubview(dailyPercentLabel)
         addSubview(volumeLabel)
         
         favoriteButton.translatesAutoresizingMaskIntoConstraints = false
         pairNameLabel.translatesAutoresizingMaskIntoConstraints = false
         lastPriceLabel.translatesAutoresizingMaskIntoConstraints = false
         dailyPercentLabel.translatesAutoresizingMaskIntoConstraints = false
         volumeLabel.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             // Favorite Button
             favoriteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
             favoriteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
             favoriteButton.widthAnchor.constraint(equalToConstant: 24),
             favoriteButton.heightAnchor.constraint(equalToConstant: 24),
             
             // Pair Name Label
             pairNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
             pairNameLabel.leadingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: 16),
             
             // Last Price Label
             lastPriceLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
             lastPriceLabel.trailingAnchor.constraint(equalTo: dailyPercentLabel.leadingAnchor, constant: -16),
             
             // Daily Percent Label
             dailyPercentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
             dailyPercentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
             
             // Volume Label
             volumeLabel.topAnchor.constraint(equalTo: pairNameLabel.bottomAnchor, constant: 4),
             volumeLabel.leadingAnchor.constraint(equalTo: pairNameLabel.leadingAnchor)
         ])
         
         favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
     }

     // MARK: - Configure Cell
     func configure(with coin: CryptoItem, isFavorite: Bool) {
         pairNameLabel.text = coin.pair
         lastPriceLabel.text = "\(coin.last)"
         dailyPercentLabel.text = "\(coin.dailyPercent)%"
         dailyPercentLabel.backgroundColor = coin.dailyPercent >= 0 ? .green : .red
         volumeLabel.text = "\(coin.pair) \(coin.pair)"
         favoriteButton.isSelected = isFavorite
     }
     
     @objc private func favoriteButtonTapped() {
         onFavoriteTapped?()
     }
 }
