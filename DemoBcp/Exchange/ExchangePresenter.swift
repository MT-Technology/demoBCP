
import UIKit

protocol ExchangeDelegate: AnyObject {
    
    func updateCurrencyExchange(currency: Currency)
}

protocol ExchangePresenterProtocol: AnyObject {
    
    func getFromCurrencyName() -> String
    func getToCurrencyName() -> String
    func getFromCurrencySymbol() -> String
    func getToCurrencySymbol() -> String
    func getExchangeRate() -> String
    func getCurrentExchangeAmount() -> String?
    func exchangeMoney(sendMoney: String) -> String
    func swapCurrency()
    func goToCurrencyList()
}

class ExchangePresenter {
    
    private unowned let view: ExchangeViewControllerProtocol
    private let interactor: ExchangeInteractorProtocol
    private let router: ExchangeRouterProtocol
    private var viewData: ExchangeViewData
    
    init(view: ExchangeViewControllerProtocol,
         interactor: ExchangeInteractorProtocol,
         router: ExchangeRouterProtocol,
         viewData: ExchangeViewData) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewData = viewData
    }
}

extension ExchangePresenter: ExchangePresenterProtocol {
    
    func getFromCurrencyName() -> String {
        viewData.fromCurrency.currencyName
    }
    
    func getToCurrencyName() -> String {
        viewData.toCurrency.currencyName
    }

    func getFromCurrencySymbol() -> String {
        viewData.fromCurrency.currencySymbol
    }
    
    func getToCurrencySymbol() -> String {
        viewData.toCurrency.currencySymbol
    }
    
    func getExchangeRate() -> String {
        if viewData.fromCurrency.currencyId == 1 {
            return String(format: "Compra: %.2f | Venta: %.2f", viewData.toCurrency.exchange.buyPrice, viewData.toCurrency.exchange.sellPrice)
        } else {
            return String(format: "Compra: %.2f | Venta: %.2f", viewData.fromCurrency.exchange.buyPrice, viewData.fromCurrency.exchange.sellPrice)
        }
    }
    
    func getCurrentExchangeAmount() -> String? {
        guard let money = viewData.exchangeAmount else {return nil}
        return String(format: "%@ %.2f", viewData.fromCurrency.currencySymbol, money)
    }
    
    func exchangeMoney(sendMoney: String) -> String {
        let moneyString = sendMoney.replacingOccurrences(of: "\(viewData.fromCurrency.currencySymbol) ", with: "")
        guard let money = Double(moneyString) else {
            return ""
        }
        viewData.exchangeAmount = money
        var exchangeAmount = 0.0
        if viewData.fromCurrency.currencyId == 1 {
            exchangeAmount = money / viewData.toCurrency.exchange.sellPrice
        } else {
            exchangeAmount = money * viewData.fromCurrency.exchange.buyPrice
        }
        return String(format: "%@ %.2f", viewData.toCurrency.currencySymbol, exchangeAmount)
    }
    
    func swapCurrency() {
        let aux = viewData.fromCurrency
        viewData.fromCurrency = viewData.toCurrency
        viewData.toCurrency = aux
        view.reloadExchange()
    }
    
    func goToCurrencyList() {
        router.routeToCurrencyList(viewData: viewData, delegate: self)
    }
}

extension ExchangePresenter: ExchangeDelegate{
    
    func updateCurrencyExchange(currency: Currency) {
        if viewData.fromCurrency.currencyId == 1 {
            viewData.toCurrency = currency
        } else {
            viewData.fromCurrency = currency
        }
        view.reloadExchange()
    }
}
