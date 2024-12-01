//
//  FavoriteCollectionViewCell.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

import Foundation
import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "FavoriteCollectionViewCell"
    
    // MARK: - UI Elements
       private let pairNameLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 14)
           label.textColor = .white
           return label
       }()
       
       private let lastPriceLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 12)
           label.textColor = .white
           return label
       }()
       
       private let dailyPercentLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 12)
           label.textAlignment = .right
           label.layer.cornerRadius = 4
           label.clipsToBounds = true
           label.textColor = .white
           return label
       }()
       
       // MARK: - Init
       override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = UIColor.darkGray
           layer.cornerRadius = 8
           clipsToBounds = true
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       // MARK: - Setup Views
       private func setupViews() {
           addSubview(pairNameLabel)
           addSubview(lastPriceLabel)
           addSubview(dailyPercentLabel)
           
           pairNameLabel.translatesAutoresizingMaskIntoConstraints = false
           lastPriceLabel.translatesAutoresizingMaskIntoConstraints = false
           dailyPercentLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               // Pair Name Label
               pairNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
               pairNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
               
               // Last Price Label
               lastPriceLabel.topAnchor.constraint(equalTo: pairNameLabel.bottomAnchor, constant: 4),
               lastPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
               
               // Daily Percent Label
               dailyPercentLabel.topAnchor.constraint(equalTo: pairNameLabel.bottomAnchor, constant: 4),
               dailyPercentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
           ])
       }
    
    // MARK: - Configure Cell
    func configure(with coin: CryptoItem) {
        pairNameLabel.text = coin.pair
        lastPriceLabel.text = "\(coin.last)"
        dailyPercentLabel.text = "\(coin.dailyPercent)%"
        dailyPercentLabel.backgroundColor = coin.dailyPercent >= 0 ? .green : .red
    }
}
