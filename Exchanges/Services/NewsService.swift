//
//  NewsService.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxSwift

protocol NewsService {
    var lastNews: Observable<[News]> { get }
    var otherNews: Observable<[News]> { get }
}
