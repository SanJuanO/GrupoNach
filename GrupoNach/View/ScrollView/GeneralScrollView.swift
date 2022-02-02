//
//  GeneralScrollView.swift
//  Cheque Bono Brown Forman
//
//  Created by Edgar Gerardo Flores Lopez on 10/10/19.
//  Copyright © 2019 Alus. All rights reserved.
//

import UIKit

class GeneralScrollView: UIScrollView {
    
    var padding = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

    public lazy var containerView: UIView = {
        let cView = UIView()
        cView.translatesAutoresizingMaskIntoConstraints = false
        cView.backgroundColor = .clear
        cView.isUserInteractionEnabled = true
        return cView
    }()
    
    init(padding: UIEdgeInsets? = nil) {
        super.init(frame: .zero)
        if let padding = padding {
            self.padding = padding
        }
        setupScroll()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScroll() {
        bounces = true
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        keyboardDismissMode = .onDrag
        
        addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.right).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom).isActive = true
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
