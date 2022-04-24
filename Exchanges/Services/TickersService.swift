//
//  TickersService.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import Foundation
import RxSwift

protocol TickersService {
    var tickers: Observable<[Ticker]> { get }
}
