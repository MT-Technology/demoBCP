
import UIKit

protocol SplashRouterProtocol: AnyObject {
    func routeToExchange(viewData: SplashViewData)
}

class SplashRouter {
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func getViewController() -> UIViewController {
        
        let vc = SplashViewController.instantiate()
        vc.presenter = SplashPresenter(view: vc,
                                       interactor: SplashInteractor(currencyRespository: CurrencyRepositoryImplementation()),
                                       router: self)
        return vc
    }
}

extension SplashRouter: SplashRouterProtocol {
    
    func routeToExchange(viewData: SplashViewData) {
        
        guard let fromCurrency = viewData.fromCurrency,
              let toCurrency = viewData.toCurrency else {return}
        
        let exchangeVD = ExchangeViewData(fromCurrency: fromCurrency,
                                          toCurrency: toCurrency)
        let vc = ExchangeRouter(navigation: navigation).getViewController(viewData: exchangeVD)
        navigation.pushViewController(vc, animated: true)
    }
}
