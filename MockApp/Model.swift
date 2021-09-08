//
//  Model.swift
//  MockApp
//
//  Created by Egor Gorskikh on 07.09.2021.
//

import Foundation

struct BitcoinResponse: Decodable {
    let USD: Details
}

struct Details: Decodable {
    let buy: Double
    let symbol: String
}
