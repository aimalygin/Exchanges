//
//  Ticker.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import Foundation

struct Ticker {
    let name: String
    let price: Double
}

extension Ticker: Codable {}
extension Ticker: Hashable {}
