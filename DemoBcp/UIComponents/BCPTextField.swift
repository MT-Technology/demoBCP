//
//  BCPTextField.swift
//  DemoBCP
//
//  Created by Mateo Espinoza on 18/12/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit

protocol BCPTextFieldDelegate: AnyObject {
    
    func bcpTextFieldShouldReturn(_ textField: UITextField) -> Bool
    
    func bcpTextFieldDidEndEditing(_ textField: UITextField)
    
    func bcpTextFieldShouldBeginEditing(_ textField: UITextField) -> Bool
}

extension BCPTextFieldDelegate {
    
    func bcpTextFieldShouldReturn(_ textField: UITextField) -> Bool {false}
    
    func bcpTextFieldDidEndEditing(_ textField: UITextField) {}
    
    func bcpTextFieldShouldBeginEditing(_ textField: UITextField) -> Bool {true}
}

class BCPTextField: UITextField {

    weak var bcpTextFieldDelegate: BCPTextFieldDelegate?
    
    
    @IBInspectable public var cornerRadius : CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set(newValue){
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
    @IBInspectable public var borderColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(newValue){
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: Float{
        get{
            return Float(self.layer.borderWidth)
        }
        set(newValue){
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable public var topMargin : CGFloat{
        get{
            return self.edgeMargin.top
        }
        set(newValue){
            self.edgeMargin.top = newValue
        }
    }
    
    @IBInspectable public var leftMargin : CGFloat{
        get{
            return self.edgeMargin.left
        }
        set(newValue){
            self.edgeMargin.left = newValue
        }
    }
    
    @IBInspectable public var rightMargin : CGFloat{
        get{
            return self.edgeMargin.right
        }
        set(newValue){
            self.edgeMargin.right = newValue
        }
    }
    
    @IBInspectable public var bottomMargin : CGFloat{
        get{
            return self.edgeMargin.bottom
        }
        set(newValue){
            self.edgeMargin.bottom = newValue
        }
    }
    
    private var edgeMargin : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    override func draw(_ rect: CGRect) {
        
        self.layer.borderWidth = CGFloat(self.borderWidth)
        self.layer.borderColor = self.borderColor.cgColor
        delegate = self
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.edgeMargin)
    }
}

extension BCPTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bcpTextFieldDelegate?.bcpTextFieldShouldReturn(textField) ?? false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        bcpTextFieldDelegate?.bcpTextFieldDidEndEditing(textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bcpTextFieldDelegate?.bcpTextFieldShouldBeginEditing(textField) ?? true
    }
}
