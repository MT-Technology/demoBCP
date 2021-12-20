
import UIKit

protocol ExchangeViewControllerProtocol: AnyObject{
    
    func updateExchangeAmount(amount: String)
    func reloadExchange()
}

class ExchangeViewController: UIViewController{
    
    @IBOutlet private weak var txtFrom: BCPMoneyTextField!
    @IBOutlet private weak var txtTo: BCPMoneyTextField!
    @IBOutlet private weak var lblFromCurrency: UILabel!
    @IBOutlet private weak var lblToCurrency: UILabel!
    @IBOutlet private weak var lblExchangeRate: UILabel!
    
    var presenter: ExchangePresenterProtocol?
    override func viewDidLoad(){
        super.viewDidLoad()
        setupCurrencies()
        setupTextField()
    }
    
    private func setupCurrencies() {
        guard let presenter = presenter else {return}
        lblFromCurrency.text = presenter.getFromCurrencyName()
        lblToCurrency.text = presenter.getToCurrencyName()
        lblExchangeRate.text = presenter.getExchangeRate()
        txtFrom.currencySymbol = presenter.getFromCurrencySymbol()
        txtTo.currencySymbol = presenter.getToCurrencySymbol()
        txtFrom.text = presenter.getCurrentExchangeAmount()
        txtTo.text = ""
    }
    
    private func setupTextField() {
        txtFrom.bcpTextFieldDelegate = self
        txtFrom.addTarget(self, action: #selector(exchangeMoney(_:)), for: .editingChanged)
    }
    
    @objc private func exchangeMoney(_ textField: UITextField) {
        guard let presenter = presenter,
              let moneyString = textField.text else { return }
        
        txtTo.text = presenter.exchangeMoney(sendMoney: moneyString)
    }
    
    @IBAction private func tapGesture(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @IBAction private func tapChangeCurrency(_ sender: UILongPressGestureRecognizer){
        
        guard sender.state == .began else {return}
        presenter?.goToCurrencyList()
    }
    
    @IBAction private func swapCurrency(_ sender: UIButton) {
        presenter?.swapCurrency()
    }
}

extension ExchangeViewController: ExchangeViewControllerProtocol{
    
    func updateExchangeAmount(amount: String) {
        txtTo.text = amount
    }
    
    func reloadExchange() {
        setupCurrencies()
        exchangeMoney(txtFrom)
        bcpTextFieldDidEndEditing(txtFrom)
    }
}

extension ExchangeViewController: BCPTextFieldDelegate{
    
    func bcpTextFieldDidEndEditing(_ textField: UITextField) {
        if let text = txtFrom.text,
           text.isEmpty {
            txtTo.text = ""
        }
    }
}
