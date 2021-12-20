
import UIKit

protocol SplashPresenterProtocol: AnyObject {
    
    func viewDidLoad()
}

class SplashPresenter {
    
    private unowned let view: SplashViewControllerProtocol
    private let interactor: SplashInteractorProtocol
    private let router: SplashRouterProtocol
    private var viewData: SplashViewData
    
    init(view: SplashViewControllerProtocol,
         interactor: SplashInteractorProtocol,
         router: SplashRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        viewData = SplashViewData()
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    
    func viewDidLoad(){
        
        interactor.getCurrencies { [weak self] result in
            guard let `self` = self else {return}
            
            switch result {
            case .success(let currencies):
                
                self.viewData.fromCurrency = currencies.first(where: { $0.currencyId == 1 })
                self.viewData.toCurrency = currencies.first(where: { $0.currencyId == 2 })
                
                self.router.routeToExchange(viewData: self.viewData)
                
            case .failure(_):
                break
            }
        }
    }
}
