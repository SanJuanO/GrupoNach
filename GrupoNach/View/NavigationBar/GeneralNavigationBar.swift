//
//  GeneralNavigationBar.swift
//  Heartland Splenda
//
//  Created by Edgar Gerardo Flores Lopez on 21/09/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import UIKit

class GeneralNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBar() {
        
        backgroundColor = .clear
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        isTranslucent = false
        
        if #available(iOS 13.0, *) {
            let largeTitlesAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.clear
            ]
            
            let titlesAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.clear
            ]
            
            titleTextAttributes = titlesAttributes
            largeTitleTextAttributes = largeTitlesAttributes
            standardAppearance.configureWithOpaqueBackground()
            standardAppearance.shadowColor = .clear
            standardAppearance.backgroundColor = .clear
            standardAppearance.largeTitleTextAttributes = titlesAttributes
            standardAppearance.titleTextAttributes = titlesAttributes
            scrollEdgeAppearance = standardAppearance
        }
        
    }
}
