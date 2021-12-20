
import UIKit

protocol ExchangeRouterProtocol: AnyObject {
    
    func routeToCurrencyList(viewData: ExchangeViewData, delegate: ExchangeDelegate?)
}

class ExchangeRouter {
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func getViewController(viewData: ExchangeViewData) -> UIViewController {
        
        let vc = ExchangeViewController.instantiate()
        vc.presenter = ExchangePresenter(view: vc,
                                         interactor: ExchangeInteractor(),
                                         router: self,
                                         viewData: viewData)
        return vc
    }
}

extension ExchangeRouter: ExchangeRouterProtocol {
    
    func routeToCurrencyList(viewData: ExchangeViewData, delegate: ExchangeDelegate?) {
        
        let currencyListVD = CurrencyListViewData(currentCurrency: [viewData.fromCurrency,
                                                                    viewData.toCurrency],
                                                  delegate: delegate)
        let vc = CurrencyListRouter(navigation: navigation).getViewController(viewData: currencyListVD)
        navigation.pushViewController(vc, animated: true)
    }
}
