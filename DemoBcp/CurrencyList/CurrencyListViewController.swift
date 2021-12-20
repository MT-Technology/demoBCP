
import UIKit

protocol CurrencyListViewControllerProtocol: AnyObject{
    
    func reloadData()
}

class CurrencyListViewController: UIViewController{
    
    @IBOutlet private weak var tbvCurrency: UITableView!
    
    var presenter: CurrencyListPresenterProtocol?
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tbvCurrency.register(CurrencyTableViewCell.nib(), forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        presenter?.viewDidLoad()
    }
}

extension CurrencyListViewController: CurrencyListViewControllerProtocol{
    
    func reloadData() {
        tbvCurrency.reloadData()
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0}
        return presenter.getCurrencyQuantity()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier, for: indexPath) as? CurrencyTableViewCell else { return UITableViewCell() }
        
        cell.imgFlagCountry.image = presenter?.getCurrencyFlagImageAtIndex(index: indexPath)
        cell.lblCountryName.text = presenter?.getCountryNameAtIndex(index: indexPath)
        cell.lblExchangeRate.text = presenter?.getCurrencyExchangeRateAtIndex(index: indexPath)
        
        return cell
    }
    
}

extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCurrencyAtIndex(index: indexPath)
    }
}
