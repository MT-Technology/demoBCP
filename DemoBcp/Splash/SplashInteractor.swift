
import UIKit

protocol SplashInteractorProtocol: AnyObject {
    
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void )
}

class SplashInteractor {
    
    let currencyRespository: CurrencyRepositoryProtocol
    
    init(currencyRespository: CurrencyRepositoryProtocol) {
        self.currencyRespository = currencyRespository
    }
}

extension SplashInteractor: SplashInteractorProtocol {
    func getCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void) {
        currencyRespository.getCurrencies(completion: completion)
    }
}
