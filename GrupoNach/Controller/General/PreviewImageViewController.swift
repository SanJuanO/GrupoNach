//
//  PreviewImageViewController.swift
//  RecompensasSuperAuto
//
//  Created by Edgar Gerardo Flores Lopez on 03/11/21.
//

import UIKit

class PreviewImageViewController: GeneralViewController {
    
    private lazy var closeButton: UIButton = {
        let cButton = UIButton()
        cButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.setTitle("CERRAR", for: .normal)
        cButton.setTitleColor(UIColor.white, for: .normal)
        cButton.addTarget(self, action: #selector(closeImage), for: .touchUpInside)
        return cButton
    }()
    
    private lazy var previewImageView: UIImageView = {
        let piView = UIImageView()
        piView.translatesAutoresizingMaskIntoConstraints = false
        piView.contentMode = .scaleAspectFit
        piView.layer.cornerRadius = 10
        piView.clipsToBounds = true
        return piView
    }()
    
    func configure(documentImage: UIImage) {
        previewImageView.image =  documentImage
    }
    
    @objc func closeImage() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func setupController() {
        view.backgroundColor = UIColor.black
        view.addSubview(closeButton)
        view.addSubview(previewImageView)
        
        closeButton.trailingAnchor.constraint(equalTo: previewImageView.trailingAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: previewImageView.topAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        previewImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        previewImageView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                                multiplier: 0.85).isActive = true
        previewImageView.heightAnchor.constraint(equalTo: previewImageView.widthAnchor,
                                                 multiplier: 1.3).isActive = true
        
    }
}
