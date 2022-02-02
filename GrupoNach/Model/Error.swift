//
//  Error.swift
//  Heartland Splenda
//
//  Created by Edgar Gerardo Flores Lopez on 18/09/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import Foundation

struct Error: Decodable {
    
    let message: String?
    let url: String?
    let code: Int?
    
}
