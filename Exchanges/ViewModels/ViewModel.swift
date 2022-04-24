//
//  ViewModel.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class ViewModel {
    
    var sections: Observable<[SectionModel]> {
        let tickersDataSource = tickersService.tickers
            .map { tickers in
                SectionModel(items: tickers.map({ .ticker(TickerViewModel(ticker: $0 ))}), sectionType: .tickers)
            }
        let lastNewsDataSource = newsService.lastNews
            .map { news in
                SectionModel(items: news.map({ .lastNews(LastNewsViewModel(news: $0 ))}), sectionType: .lastNews)
            }
        let newsDataSource = newsService.otherNews
            .map { news in
                SectionModel(items: news.map({ .news(NewsViewModel(news: $0 ))}), sectionType: .otherNews)
            }
        return Observable.merge(tickersDataSource, lastNewsDataSource, newsDataSource)
            .scan(into: [SectionModel].emptySections()) { accum, new in
                if let index = accum.firstIndex(where: { $0.sectionType == new.sectionType }) {
                    accum[index] = new
                }
            }
    }
    
    private let tickersService: TickersService
    private let newsService: NewsService
    
    init(
        tickersService: TickersService,
        newsService: NewsService
    ) {
        self.tickersService = tickersService
        self.newsService = newsService
    }
}

fileprivate extension Array where Element == SectionModel {
    static func emptySections() -> [Element] {
        Section.allCases.map { section in
            SectionModel(sectionType: section)
        }
    }
}
