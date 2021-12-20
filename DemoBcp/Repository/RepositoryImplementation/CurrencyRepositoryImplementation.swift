//
//  CurrencyRepositoryImplementation.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import Foundation

class CurrencyRepositoryImplementation: CurrencyRepositoryProtocol {
    
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        
        if let path = Bundle.main.path(forResource: "currencyData", ofType: "json"){
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let currenciesResponse = try JSONDecoder().decode([CurrencyResponse].self, from: data)
                
                let currencies = currenciesResponse.map({
                    Currency(currencyId: $0.currencyId,
                             currencyName: $0.currencyName,
                             currencySymbol: $0.currencySymbol,
                             currencyISO: $0.currencyISO,
                             country: Country(name: $0.countryName,
                                              flagImageName: $0.countryFlagImageName),
                             exchange: Exchange(buyPrice: $0.currencyBuy,
                                                sellPrice: $0.currencySell))
                })
                
                completion(.success(currencies))
                
            } catch {
                completion(.failure(error))
            }
        } 
    }
}
