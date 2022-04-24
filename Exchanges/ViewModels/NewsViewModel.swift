//
//  NewsViewModel.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxNuke
import Nuke
import RxDataSources

final class NewsViewModel {
    var image: Driver<UIImage?> {
        ImagePipeline.shared.rx
            .loadImage(with: news.imageUrl)
            .map({ $0.image })
            .asDriver(onErrorJustReturn: nil)
    }
    
    var title: String {
        news.title
    }
    
    var description: String {
        news.description
    }
    
    var dateString: String {
        dateFormatter.string(from: news.date)
    }
    
    private let news: News
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }
    
    init(news: News) {
        self.news = news
    }
}

extension NewsViewModel: Equatable {
    static func == (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        lhs.news == rhs.news
    }
}

extension NewsViewModel: IdentifiableType {
    var identity: AnyHashable {
        news
    }
}
