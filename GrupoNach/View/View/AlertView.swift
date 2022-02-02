//
//  GrupoNach
//
//  Created by Oscar San juan on 01/02/22.
//

import UIKit

class AlertView: UIView {
    
    private lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = UIColor.white
        cView.layer.cornerRadius = 20
        cView.layer.shadowRadius = 20
        cView.layer.shadowOpacity = 0.15
        cView.layer.shadowColor = UIColor.black.cgColor
        cView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cView.layer.masksToBounds = false
        cView.clipsToBounds = false
        return cView
    }()
        
    public lazy var iconView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.image = UIImage(named: "logo")
        return iView
    }()
        
    public lazy var titleLabel: UILabel = {
        let tLabel = UILabel()
        tLabel.translatesAutoresizingMaskIntoConstraints = false
        tLabel.textColor = UIColor.black
        tLabel.textAlignment = .center
        tLabel.text = "Alerta"
        tLabel.numberOfLines = 2
        return tLabel
    }()
    
    public lazy var messageTextView: UILabel = {
        let sLabel = UILabel()
        sLabel.translatesAutoresizingMaskIntoConstraints = false
        sLabel.textColor = UIColor.black
        sLabel.textAlignment = .center
        sLabel.isUserInteractionEnabled = false
        sLabel.numberOfLines = 0
        sLabel.text = """
                      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed \
                      do eiusmod tempor incididunt ut labore et dolore magna aliqua. \
                      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris \
                      nisi ut aliquip ex ea commodo consequat.
                      """
        return sLabel
    }()
    
    private lazy var separatorView: UIView = {
        let sView = UIView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.backgroundColor = UIColor.black
        return sView
    }()
    
    private lazy var stackView: UIStackView = {
        let sView = UIStackView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.axis = .horizontal
        sView.distribution = .fillEqually
        sView.spacing = 10
        return sView
    }()
    
    public lazy var dismissButton:UIButton = {
        let lButton = UIButton()
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        lButton.translatesAutoresizingMaskIntoConstraints = false
        lButton.setTitle("Aceptar", for: .normal)
        lButton.layer.masksToBounds = true
        lButton.backgroundColor = UIColor.clear
        lButton.layer.borderWidth = 1.0
        lButton.layer.borderColor = UIColor.black.cgColor
        lButton.setTitleColor(UIColor.black, for: .normal)
        lButton.layer.cornerRadius = cornerRadius
        return lButton
    }()
    
    public lazy var actionButton: UIButton = {
        let aButton = UIButton()
        aButton.translatesAutoresizingMaskIntoConstraints = false
        aButton.isHidden = true
        aButton.backgroundColor = UIColor.blue
        aButton.setTitle("SÍ", for: .normal)
        return aButton
    }()
    
    var actions: [(UIAlertAction) -> Void] = [(UIAlertAction) -> Void]() {
        didSet {
            if actions.first != nil {
                dismissButton.isHidden = false
//                actionButton.addTarget(self, action: #selector(), for: .touchUpInside)
            } else {
                dismissButton.isHidden = true
            }
            
            if actions.last != nil {
                actionButton.isHidden = false
            } else {
                actionButton.isHidden = true
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AlertView {
    func setupView() {
        addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageTextView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(dismissButton)
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                
        iconView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                      constant: 10).isActive = true
        iconView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor,
                                        constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor,
                                          multiplier: 0.8).isActive = true
        
        messageTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                             constant: 05).isActive = true
        messageTextView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        messageTextView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        
       
        
        stackView.topAnchor.constraint(equalTo: messageTextView.bottomAnchor,
                                             constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: messageTextView.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        stackView.widthAnchor.constraint(equalTo: messageTextView.widthAnchor).isActive = true

    }
}
