//
//  LoginTextField.swift
//  RecompensasSuperAuto
//
//  Created by Sergio Acosta Vega on 11/6/21.
//

import UIKit

class LoginTextField: UITextField {
    var colorwhite = true
    private var padding = UIEdgeInsets(top: 30, left: 0, bottom: 10, right: 0)
    
    public lazy var bottomView: UIView = {
        let bView = UIView()
        bView.translatesAutoresizingMaskIntoConstraints = false
        bView.backgroundColor = .white
        return bView
    }()
    
    public lazy var titleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.textColor = .black
        return tLabel
    }()
    
    override var placeholder: String? {
        get {
            return super.placeholder
        } set {
            super.placeholder = newValue
//            titleLabel.text = newValue
            
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.left
        
         
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupTextField() {
        
        
        
        addSubview(titleLabel)
        addSubview(bottomView)

        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        bottomView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
}
