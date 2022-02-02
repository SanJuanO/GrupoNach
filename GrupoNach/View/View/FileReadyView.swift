//
//  FileReadyView.swift
//  RecompensasSuperAuto
//
//  Created by Edgar Gerardo Flores Lopez on 03/11/21.
//

import UIKit

class FileReadyView: UIView {
    
    private lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor.gray
        cView.layer.cornerRadius = 20
        return cView
    }()
    
    private lazy var circleImageView: UIImageView = {
        let ciView = UIImageView()
        ciView.translatesAutoresizingMaskIntoConstraints = false
        ciView.image = UIImage(named: "successIcon")
        return ciView
    }()

    private lazy var readyLabel: UILabel = {
        let rLabel = UILabel()
        rLabel.translatesAutoresizingMaskIntoConstraints = false
        rLabel.textColor = .black
        rLabel.text = "Selfi"
        return rLabel
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
        containerView.addSubview(circleImageView)
        containerView.addSubview(readyLabel)

        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        circleImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0).isActive = true
        circleImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        circleImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        circleImageView.widthAnchor.constraint(equalTo: circleImageView.heightAnchor).isActive = true
        
        readyLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: 3.0).isActive = true
        readyLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        readyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -7.0).isActive = true
        readyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}
