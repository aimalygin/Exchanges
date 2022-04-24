//
//  Container+Shared.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import Swinject

extension Container {
    static let shared: Container = {
        let container = Container()
        
        container.register(NetworkService.self) { _ in
            NetworkServiceImpl()
        }.inObjectScope(.container)
        
        container.register(TickersService.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self)!
            return TickersServiceImpl(networkService: networkService)
        }.inObjectScope(.container)
        
        container.register(NewsService.self) { resolver in
            let networkService = resolver.resolve(NetworkService.self)!
            return NewsServiceImpl(networkService: networkService)
        }.inObjectScope(.container)
        
        container.register(ViewModel.self) { resolver in
            let tickersService = resolver.resolve(TickersService.self)!
            let newsService = resolver.resolve(NewsService.self)!
            return ViewModel(tickersService: tickersService, newsService: newsService)
        }
        
        
        return container
    }()
}
