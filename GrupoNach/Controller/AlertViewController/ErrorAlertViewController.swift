//
//  ErrorAlertViewController.swift
//  Heartland Splenda
//
//  Created by Edgar Gerardo Flores Lopez on 05/10/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import UIKit

class ErrorAlertViewController: GeneralViewController {
        
    public lazy var alertView: AlertView = {
        let cView = AlertView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.iconView.image = UIImage(named: "logo")
        cView.titleLabel.text = "¡Ups!"
        cView.messageTextView.text = "Ocurrio un error"
        cView.dismissButton.setTitle("Aceptar", for: .normal)
        cView.dismissButton.addTarget(self, action: #selector(dismissController),
                                      for: .touchUpInside)
        return cView
    }()
    
    @objc func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func setupController() {
        super.setupController()
                
        view.addSubview(alertView)

        alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        alertView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
}
