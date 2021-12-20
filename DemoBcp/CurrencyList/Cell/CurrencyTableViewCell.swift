//
//  CurrencyTableViewCell.swift
//  DemoBcp
//
//  Created by Mateo Espinoza on 18/12/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    static let identifier = "CurrencyTableViewCell"
    
    @IBOutlet weak var imgFlagCountry: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblExchangeRate: UILabel!
        
}
