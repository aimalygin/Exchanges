//
//  Item.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation

enum Item {
    case ticker(TickerViewModel)
    case lastNews(LastNewsViewModel)
    case news(NewsViewModel)
}
