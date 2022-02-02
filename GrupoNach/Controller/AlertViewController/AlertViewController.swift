//
//  RedemptionAlertViewController.swift
//  Atrevete A Ganar
//
//  Created by Edgar Gerardo Flores Lopez on 05/10/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import UIKit

class AlertViewController: GeneralViewController, DocumentsViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
    weak var delegate: ImageViewDelegate?
    var image: UIImage?
    private lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = .white
        cView.layer.cornerRadius = 17.0
        cView.layer.masksToBounds = true
        return cView
    }()
    
    private lazy var titleLabel: UILabel = {
        let sToLabel = UILabel()
        sToLabel.translatesAutoresizingMaskIntoConstraints = false
        sToLabel.text = "Fotografia"
        sToLabel.textAlignment = .center
        sToLabel.numberOfLines = 0
        return sToLabel
    }()
    
    private lazy var messageLabel: DocumentView = {
        let iView = DocumentView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.pictureButton.tag = 0
        iView.previewButton.tag = 0
        iView.deleteButton.tag = 0
        iView.delegate = self
        iView.pictureView.isHidden = true
        return iView
    }()
        
    private lazy var separatorView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .black
        return sView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let hsView = UIStackView()
        hsView.translatesAutoresizingMaskIntoConstraints = false
        hsView.axis = .horizontal
        hsView.distribution = .fill
        return hsView
    }()
    
    public lazy var dismissButton: UIButton = {
        let cButton = UIButton()
        cButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.setTitle("Aceptar", for: .normal)
        cButton.setTitleColor(.black, for: .normal)
        cButton.addTarget(self, action: #selector(cancelRedemption), for: .touchUpInside)
        return cButton
    }()
    
    public lazy var verticalSeparatorView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .black
        return sView
    }()
    

            
    func configure(message: String) {
    }
    
    @objc private func cancelRedemption() {
        dismiss(animated: true)
    }
    
    override func setupController() {
        super.setupController()
        view.backgroundColor = UIColor.black
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(separatorView)
        containerView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(dismissButton)
        horizontalStackView.addArrangedSubview(verticalSeparatorView)
        
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             multiplier: 1).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30.0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30.0).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
                        
        separatorView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true

        horizontalStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        verticalSeparatorView.widthAnchor.constraint(equalToConstant: 1.0).isActive = true
     }
    
    func didTapCamera(documentType: Int) {
        
         #if targetEnvironment(simulator)
             print("simulator")
             let imagePicker = UIImagePickerController()
             imagePicker.allowsEditing = false
     
             imagePicker.mediaTypes = ["public.image"]
             imagePicker.sourceType = .savedPhotosAlbum
             imagePicker.delegate = self
       imagePicker.cameraCaptureMode
             present(imagePicker, animated: true, completion: nil)
         #else
             print("real device")
             let imagePicker = UIImagePickerController()
             imagePicker.allowsEditing = false
             imagePicker.mediaTypes = ["public.image"]
             imagePicker.sourceType = .camera
             imagePicker.delegate = self
             present(imagePicker, animated: true, completion: nil)
         #endif
         
         
     }
    
    
    func didDeletePicture(documentType: Int) {
        self.messageLabel.pictureView.isHidden = true
        self.messageLabel.documentImageView.image = UIImage()
    }
    
    func didPreviewPicture(documentType: Int) {
        let detailController = PreviewImageViewController()
        detailController.configure(documentImage: self.image ?? UIImage())
        detailController.modalTransitionStyle = .crossDissolve
        detailController.modalPresentationStyle = .custom
        present(detailController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        guard let image = info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        self.image = image
                self.messageLabel.pictureView.isHidden = false
                self.messageLabel.documentImageView.image = image
           
            //Comprimir y reajustar orientación
           
            self.refreshControl.endRefreshing()
        if let base64 = image.jpegData(compressionQuality: 0.45)?.base64EncodedString() {
            self.delegate?.image(image: base64)
        }
        
        
        
        picker.dismiss(animated: true, completion: nil)
    }
}

