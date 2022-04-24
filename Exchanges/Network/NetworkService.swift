//
//  NetworkService.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import Foundation
import RxSwift

protocol NetworkService {
    
    func getTickers() async throws -> [Ticker]
    func getNews() async throws -> [News]
    
}
