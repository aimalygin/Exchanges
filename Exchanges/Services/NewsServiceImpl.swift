//
//  NewsServiceImpl.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxSwift

final class NewsServiceImpl: NewsService {
    var lastNews: Observable<[News]> {
        subject
            .map({ Array($0.prefix(6)) })
            .asObservable()
    }
    
    var otherNews: Observable<[News]> {
        subject
            .map({ news in
                if news.count > 6 {
                    return Array(news.suffix(news.count - 6))
                } else {
                    return news
                }
            })
            .asObservable()
    }
    
    private let subject: BehaviorSubject<[News]>
    private let bag = DisposeBag()
    
    init(networkService: NetworkService) {
        let subject = BehaviorSubject<[News]>(value: [])
        Observable<[News]>.create { observer in
            let task = Task {
                do {
                    let news = try await networkService.getNews()
                    observer.onNext(news)

                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }

            return Disposables.create { task.cancel() }
        }.subscribe(subject)
            .disposed(by: bag)
        
        self.subject = subject
    }
}
