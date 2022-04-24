//
//  TickerViewModel.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import PinLayout
import RxDataSources

final class TickerViewModel {
    
    var name: String {
        ticker.name
    }
    
    var price: String {
        let roundedValue = round(ticker.price * 100) / 100.0
        return "\(roundedValue)"
    }
    
    private let ticker: Ticker
    
    init(ticker: Ticker) {
        self.ticker = ticker
    }
}

extension TickerViewModel: Equatable {
    static func == (lhs: TickerViewModel, rhs: TickerViewModel) -> Bool {
        lhs.ticker == rhs.ticker
    }
}

extension TickerViewModel: IdentifiableType {
    var identity: AnyHashable {
        ticker.name
    }
}
