
import UIKit

protocol CurrencyListPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func getCurrencyQuantity() -> Int
    func getCurrencyFlagImageAtIndex(index: IndexPath) -> UIImage?
    func getCountryNameAtIndex(index: IndexPath) -> String?
    func getCurrencyExchangeRateAtIndex(index: IndexPath) -> String?
    func selectCurrencyAtIndex(index: IndexPath)
}

class CurrencyListPresenter {
    
    private unowned let view: CurrencyListViewControllerProtocol
    private let interactor: CurrencyListInteractorProtocol
    private let router: CurrencyListRouterProtocol
    private var viewData: CurrencyListViewData
    
    init(view: CurrencyListViewControllerProtocol,
         interactor: CurrencyListInteractorProtocol,
         router: CurrencyListRouterProtocol,
         viewData: CurrencyListViewData) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewData = viewData
    }
}

extension CurrencyListPresenter: CurrencyListPresenterProtocol {
    
    func viewDidLoad(){
        
        interactor.getCurrencies { [weak self] result in
            guard let `self` = self else {return}
            
            switch result {
            case .success(let currencies):
                self.viewData.dataSource = currencies.filter({ !self.viewData.currentCurrency.contains($0) })
                self.view.reloadData()
            case .failure(_):
                break
            }
        }
    }
    
    func getCurrencyQuantity() -> Int {
        viewData.dataSource?.count ?? 0
    }
    
    func getCurrencyFlagImageAtIndex(index: IndexPath) -> UIImage? {
        guard let flagImageName = viewData.dataSource?[index.row].country.flagImageName else {return nil}
        return UIImage(named: flagImageName)
    }
    
    func getCountryNameAtIndex(index: IndexPath) -> String? {
        viewData.dataSource?[index.row].country.name
    }
    
    func getCurrencyExchangeRateAtIndex(index: IndexPath) -> String? {
        guard let iso = viewData.dataSource?[index.row].currencyISO,
              let exchange = viewData.dataSource?[index.row].exchange.sellPrice else {return nil}
        return String(format: "1 %@ = %.2f PEN", iso, exchange) 
    }
    
    func selectCurrencyAtIndex(index: IndexPath) {
        guard let currency = viewData.dataSource?[index.row] else { return }
        viewData.delegate?.updateCurrencyExchange(currency: currency)
        router.back()
    }
}
