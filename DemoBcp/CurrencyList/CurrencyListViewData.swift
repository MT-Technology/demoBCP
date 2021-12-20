
import UIKit

struct CurrencyListViewData {
    
    let currentCurrency: [Currency]
    weak var delegate: ExchangeDelegate?
    var dataSource: [Currency]?
}
