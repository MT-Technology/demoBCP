
import UIKit

protocol CurrencyListRouterProtocol: AnyObject {
    func back()
}

class CurrencyListRouter {
    
    var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func getViewController(viewData: CurrencyListViewData) -> UIViewController {
        
        let vc = CurrencyListViewController.instantiate()
        vc.presenter = CurrencyListPresenter(view: vc,
                                             interactor: CurrencyListInteractor(currencyRespository: CurrencyRepositoryImplementation()),
                                             router: self,
                                             viewData: viewData)
        return vc
    }
}

extension CurrencyListRouter: CurrencyListRouterProtocol {
    
    func back() {
        navigation.popViewController(animated: true)
    }
}
