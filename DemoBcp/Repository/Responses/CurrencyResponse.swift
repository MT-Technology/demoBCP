//
//  Currency.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import Foundation

struct CurrencyResponse: Codable {
    
    var currencyId: Int
    var currencyName: String
    var currencySymbol: String
    var currencyISO: String
    var countryName: String
    var countryFlagImageName: String
    var currencyBuy: Double
    var currencySell: Double
    
    enum CodingKeys: String, CodingKey {
        
        case currencyId = "id"
        case currencyName = "name"
        case currencySymbol = "symbol"
        case currencyISO = "iso"
        case countryName = "country"
        case countryFlagImageName = "flagImageName"
        case currencyBuy = "buy"
        case currencySell = "sell"
    }
}
