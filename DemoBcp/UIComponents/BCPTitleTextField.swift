//
//  BCPTitleTextField.swift
//  DemoBCP
//
//  Created by Mateo Espinoza on 18/12/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class BCPTitleTextField: BCPTextField {

    @IBInspectable var titleColor: UIColor{
        get{
            return self.internalTitleColor
        }
        set(newValue){
            self.internalTitleColor = newValue
        }
    }
    
    @IBInspectable var titleString: String{
        get{
            return self.internalTitleString
        }
        set(newValue){
            self.internalTitleString = newValue
        }
    }
    
    @IBInspectable var titleTopPadding: CGFloat{
        get{
            return self.internalTopPadding
        }
        set(newValue){
            self.internalTopPadding = newValue
        }
    }
    
    @IBInspectable var titleLeftPadding: CGFloat{
        get{
            return self.internalLeftPadding
        }
        set(newValue){
            self.internalLeftPadding = newValue
        }
    }
    
    @IBInspectable var titleFontSize: CGFloat{
        get{
            return self.internalTitleFontSize
        }
        set(newValue){
            self.internalTitleFontSize = newValue
        }
    }
    
    private var internalTopPadding: CGFloat = 0.0
    private var internalLeftPadding: CGFloat = 0.0
    private var internalTitleString: String = ""
    private var internalTitleFontSize: CGFloat = 0.0
    private var internalTitleColor: UIColor = .black
    
    lazy var lblTitle: UILabel = {
        let _lblTitle = UILabel()
        _lblTitle.translatesAutoresizingMaskIntoConstraints = false
        _lblTitle.text = self.internalTitleString
        _lblTitle.textColor = self.internalTitleColor
        _lblTitle.font = .systemFont(ofSize: self.internalTitleFontSize)
        return _lblTitle
    }()
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        self.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: internalTopPadding).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: internalLeftPadding).isActive = true
        
    }
}
