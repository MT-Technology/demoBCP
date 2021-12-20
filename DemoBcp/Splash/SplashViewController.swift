
import UIKit

protocol SplashViewControllerProtocol: AnyObject{
    
}

class SplashViewController: UIViewController{
    
    var presenter: SplashPresenterProtocol?
    override func viewDidLoad(){
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SplashViewController: SplashViewControllerProtocol{
    
}
