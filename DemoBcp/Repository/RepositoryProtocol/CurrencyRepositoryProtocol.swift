//
//  CurrencyRepositoryProtocol.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import Foundation

protocol CurrencyRepositoryProtocol {
    func getCurrencies(completion: @escaping (Result<[Currency],Error>) -> Void )
}
