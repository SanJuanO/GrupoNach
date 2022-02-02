//
//  Success.swift
//  Heartland Splenda
//
//  Created by Edgar Gerardo Flores Lopez on 18/09/20.
//  Copyright © 2020 Edgar Gerardo Flores Lopez. All rights reserved.
//

import Foundation

struct Success: Decodable {
    let colors: [String]
    let questions: [questionMapper]
}
struct questionMapper: Codable {
    let total: Int
    let text: String
    let chartData: [CharDataMapper]
}
struct CharDataMapper: Codable {
    let text: String
    let percetnage: Int
}
