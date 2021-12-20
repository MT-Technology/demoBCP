//
//  Currency.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import Foundation

struct Currency {
    
    let currencyId: Int
    let currencyName: String
    let currencySymbol: String
    let currencyISO: String
    let country: Country
    let exchange: Exchange
}

extension Currency: Equatable {
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.currencyId == rhs.currencyId
        }
}
