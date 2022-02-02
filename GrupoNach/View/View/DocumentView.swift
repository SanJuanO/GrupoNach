//
//  DocumentView.swift
//  RecompensasSuperAuto
//
//  Created by Edgar Gerardo Flores Lopez on 03/11/21.
//

import UIKit

class DocumentView: UIView {
        
    weak var delegate: DocumentsViewDelegate?

    private lazy var verticalStackView: UIStackView = {
        let vsView = UIStackView()
        vsView.translatesAutoresizingMaskIntoConstraints = false
        vsView.distribution = .fill
        vsView.axis = .vertical
        return vsView
    }()

    private lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = .white
        cView.layer.cornerRadius = 10
        cView.layer.borderWidth = 1.2
        cView.layer.borderColor = UIColor.black.cgColor
        return cView
    }()

    public lazy var documentView: UIView = {
        let dView = UIView()
        dView.translatesAutoresizingMaskIntoConstraints = false
        return dView
    }()
    
    public lazy var titleLabel: UILabel = {
        let yTextField = UILabel()
        yTextField.translatesAutoresizingMaskIntoConstraints = false
        yTextField.textColor = .black
        yTextField.text = "Foto"
        return yTextField
    }()
        
    public lazy var subtitleLabel: UITextView = {
        let yTextField = UITextView()
        yTextField.translatesAutoresizingMaskIntoConstraints = false
        yTextField.textColor = .black
        yTextField.text = "Toma una selfi"
        yTextField.isScrollEnabled = false
        yTextField.isUserInteractionEnabled = false
        return yTextField
    }()

    public lazy var pictureButton: UIButton = {
        let sYearButton = UIButton()
        sYearButton.translatesAutoresizingMaskIntoConstraints = false
        sYearButton.setImage(UIImage(named: "cameraIcon"), for: .normal)
        sYearButton.addTarget(self, action: #selector(didTapPictureButton), for: .touchUpInside)
        return sYearButton
    }()

    public lazy var pictureView: UIView = {
        let pView = UIView()
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.isHidden = false
        return pView
    }()
    
    private lazy var readyImageView: FileReadyView = {
        let riView = FileReadyView()
        riView.translatesAutoresizingMaskIntoConstraints = false
        return riView
    }()
        
    private lazy var separatorView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = .black
        return sView
    }()
    
    public lazy var documentImageView: UIImageView = {
        let diView = UIImageView()
        diView.translatesAutoresizingMaskIntoConstraints = false
        diView.image = UIImage(named: "bannerImage")
        diView.contentMode = .scaleAspectFill
        diView.clipsToBounds = true
        return diView
    }()
    
    public lazy var previewButton: UIButton = {
        let pButton = UIButton()
        pButton.translatesAutoresizingMaskIntoConstraints = false
        pButton.setTitle("Ver", for: .normal)
        pButton.backgroundColor = UIColor.gray
        pButton.setTitleColor(UIColor.black, for: .normal)
        pButton.layer.cornerRadius = 20
        pButton.addTarget(self, action: #selector(didPreviewPicture), for: .touchUpInside)
        return pButton
    }()
    
    public lazy var deleteButton: UIButton = {
        let dButton = UIButton()
        dButton.translatesAutoresizingMaskIntoConstraints = false
        dButton.setTitle("Eliminar", for: .normal)
        dButton.backgroundColor = UIColor.red
        dButton.layer.cornerRadius = 20
        dButton.addTarget(self, action: #selector(didDeletePicture), for: .touchUpInside)
        return dButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(documentView)
        documentView.addSubview(titleLabel)
        documentView.addSubview(subtitleLabel)
        documentView.addSubview(pictureButton)
        verticalStackView.addArrangedSubview(pictureView)
        pictureView.addSubview(readyImageView)
        pictureView.addSubview(separatorView)
        pictureView.addSubview(documentImageView)
        pictureView.addSubview(previewButton)
        pictureView.addSubview(deleteButton)

        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                   constant: 17).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                               constant: 20).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                    constant: -17).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                  constant: -20).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: documentView.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: documentView.topAnchor, constant: 15.0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true

        subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: documentView.bottomAnchor,
                                              constant: -30).isActive = true
        
        pictureButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
        pictureButton.trailingAnchor.constraint(equalTo: documentView.trailingAnchor, constant: -10).isActive = true
        pictureButton.centerYAnchor.constraint(equalTo: documentView.centerYAnchor).isActive = true
        pictureButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        pictureButton.widthAnchor.constraint(equalTo: pictureButton.heightAnchor).isActive = true
        
        readyImageView.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor).isActive = true
        readyImageView.topAnchor.constraint(equalTo: pictureView.topAnchor).isActive = true
        readyImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        readyImageView.widthAnchor.constraint(equalTo: pictureView.widthAnchor, multiplier: 0.5).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: readyImageView.leadingAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: readyImageView.bottomAnchor, constant: 10.0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        documentImageView.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor).isActive = true
        documentImageView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10.0).isActive = true
        documentImageView.trailingAnchor.constraint(equalTo: pictureView.centerXAnchor).isActive = true
        documentImageView.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor).isActive = true
        documentImageView.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        
        deleteButton.leadingAnchor.constraint(equalTo: documentImageView.trailingAnchor, constant: 20.0).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: documentImageView.bottomAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        previewButton.leadingAnchor.constraint(equalTo: deleteButton.leadingAnchor).isActive = true
        previewButton.topAnchor.constraint(greaterThanOrEqualTo:
                                            separatorView.bottomAnchor, constant: 40).isActive = true
        previewButton.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor).isActive = true
        previewButton.bottomAnchor.constraint(equalTo: deleteButton.topAnchor, constant: -5.0).isActive = true
        previewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func didTapPictureButton(sender: UIButton) {
        if let delegate = delegate {
            delegate.didTapCamera(documentType: sender.tag)
        }
    }
    
    @objc func didDeletePicture(sender: UIButton) {
        if let delegate = delegate {
            delegate.didDeletePicture(documentType: sender.tag)
        }
    }
    
    @objc func didPreviewPicture(sender: UIButton) {
        if let delegate = delegate {
            delegate.didPreviewPicture(documentType: sender.tag)
        }
    }

}
