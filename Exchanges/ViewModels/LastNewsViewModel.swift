//
//  LastNewsViewModel.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxCocoa
import RxNuke
import Nuke
import RxDataSources

final class LastNewsViewModel {
    var image: Driver<UIImage?> {
        ImagePipeline.shared.rx
            .loadImage(with: news.imageUrl)
            .map({ $0.image })
            .asDriver(onErrorJustReturn: nil)
    }
    
    var title: String {
        news.title
    }
    
    private let news: News
    
    init(news: News) {
        self.news = news
    }
}

extension LastNewsViewModel: Equatable {
    static func == (lhs: LastNewsViewModel, rhs: LastNewsViewModel) -> Bool {
        lhs.news == rhs.news
    }
}

extension LastNewsViewModel: IdentifiableType {
    var identity: AnyHashable {
        news
    }
}
