//
//  News.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import Foundation

struct News {
    let title: String
    let date: Date
    let imageUrl: URL
    let description: String
}

extension News: Hashable {}
