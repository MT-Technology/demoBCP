//
//  BCPMoneyTextField.swift
//  DemoBCP
//
//  Created by Mateo Espinoza on 18/12/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import Foundation
import UIKit

class BCPMoneyTextField: BCPTitleTextField{
    
    @IBInspectable var currencySymbol: String{
        get{
            return self.internalSymbol
        }
        set(newValue){
            self.internalSymbol = newValue
        }
    }
    
    private var internalSymbol: String = "S/"
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        self.delegate = self
    }
}

extension BCPMoneyTextField {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text else {return}
        
        if text.isEmpty{
            textField.text = "\(internalSymbol) "
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        
        var text = textField.text ?? ""
        if text == "\(internalSymbol) " ||
            text == "\(internalSymbol) 0" ||
            text == "\(internalSymbol) 0." ||
            text == "\(internalSymbol) 0.0" ||
            text == "\(internalSymbol) 0.00"{
            text = ""
        }else if !text.contains("."){
            text += ".00"
        }else if text.split(separator: ".").count == 1{
            text += "00"
        }else if let decimals = text.split(separator: ".").last,
            decimals.count == 1 {
            text += "0"
        }
        textField.text = text
        
        bcpTextFieldDelegate?.bcpTextFieldDidEndEditing(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {return false}
        
        if range.location < (internalSymbol.count + 1){return false}
        if string == "" && (textField.text?.count ?? 0) <= (internalSymbol.count + 1) {return false}
        if string == ""{return true}
        if text.count == (internalSymbol.count + 1) && string == "."{return false}
        if text == "0" && string != "."{return false}
        if text == "\(internalSymbol) 0" && string == "0"{return false}
        if text.replacingOccurrences(of: "\(internalSymbol) ", with: "")    .contains(".") == true && string == "."{return false}
        if let number = textField.text?.replacingOccurrences(of: "\(internalSymbol) ", with: "").split(separator: "."),
                number.count > 1, number.last?.count == 2{return false}
        
        return true
    }
}
