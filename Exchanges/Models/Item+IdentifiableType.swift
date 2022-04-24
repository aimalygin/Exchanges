//
//  Item+IdentifiableType.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxDataSources

extension Item: IdentifiableType {
    var identity: some Hashable {
        switch self {
        case .ticker(let tickerViewModel):
            return tickerViewModel.identity
        case .lastNews(let lastNewsViewModel):
            return lastNewsViewModel.identity
        case .news(let newsViewModel):
            return newsViewModel.identity
        }
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        switch (lhs, rhs) {
        case let (.ticker(lhsTickerViewModel), .ticker(rhsTickerViewModel)):
            return lhsTickerViewModel == rhsTickerViewModel
        case let (.lastNews(lhsViewModel), .lastNews(rhsViewModel)):
            return lhsViewModel == rhsViewModel
        case let (.news(lhsViewModel), .news(rhsViewModel)):
            return lhsViewModel == rhsViewModel
        default:
            return false
        }
    }
}
