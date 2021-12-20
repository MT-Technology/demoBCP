
import UIKit

protocol CurrencyListInteractorProtocol: AnyObject {
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void )
}

class CurrencyListInteractor {
    
    let currencyRespository: CurrencyRepositoryProtocol
    
    init(currencyRespository: CurrencyRepositoryProtocol) {
        self.currencyRespository = currencyRespository
    }
}

extension CurrencyListInteractor: CurrencyListInteractorProtocol {
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        currencyRespository.getCurrencies(completion: completion)
    }
}
