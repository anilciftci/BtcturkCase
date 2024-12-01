//
//  CryptoItem.swift
//  BtcturkCase
//
//  Created by Mehmet Anıl Çiftçi on 30.11.2024.
//

struct CryptoItem: Decodable {
    let pair: String
    let last: Double
    let dailyPercent: Double
    let volume: Double
    let numeratorSymbol: String
    let order: Int
}

//"pair":"AVAXUSDT",
//"pairNormalized":"AVAX_USDT",
//"timestamp":1622451620541,
//"last":17.198,
//"high":17.453,
//"low":14.000,
//"bid":17.025,
//"ask":17.198,
//"open":17.001,
//"volume":20970.55,
//"average":16.74,
//"daily":0.197,
//"dailyPercent":1.16,
//"denominatorSymbol":"USDT",
//"numeratorSymbol":"AVAX",
//"order":2005
