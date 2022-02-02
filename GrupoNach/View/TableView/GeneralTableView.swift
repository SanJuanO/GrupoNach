//
//  GeneralTableView.swift
//  Atrevete A Ganar
//
//  Created by Edgar Gerardo Flores Lopez on 03/10/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import UIKit

class GeneralTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        allowsMultipleSelection = false
        keyboardDismissMode = .onDrag
        backgroundColor = UIColor.clear
    }
}
