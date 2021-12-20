//
//  Utils.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import UIKit

extension UIViewController {
    
    class func instantiate() -> Self {
        
        func instantiateFromNib<T: UIViewController>() -> T {
            T(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
}

extension UITableViewCell {
    
    class func nib() -> UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }
}
