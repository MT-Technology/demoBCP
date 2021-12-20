//
//  BCPButton.swift
//  DemoBCP
//
//  Created by Mateo Espinoza on 18/12/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

class BCPButton: UIButton {

   @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = self.cornerRadius
    }
}
