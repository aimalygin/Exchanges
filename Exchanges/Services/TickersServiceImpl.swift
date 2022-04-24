//
//  TickersServiceImpl.swift
//  Exchanges
//
//  Created by Anton Malygin on 23.04.2022.
//

import Foundation
import RxSwift
import RxRelay

final class TickersServiceImpl: TickersService {
    var tickers: Observable<[Ticker]> {
        subject.asObservable()
    }
    
    private let subject: BehaviorSubject<[Ticker]>
    private let bag = DisposeBag()
    private let scheduler: SerialDispatchQueueScheduler
    
    init(
        networkService: NetworkService,
        scheduler: SerialDispatchQueueScheduler = SerialDispatchQueueScheduler(
            internalSerialQueueName: "TickersServiceScheduler"
        )
    ) {
        let subject = BehaviorSubject<[Ticker]>(value: [])
        
        Observable<[Ticker]>.create { observer in
            let task = Task {
                do {
                    let tickers = try await networkService.getTickers()
                    observer.onNext(tickers)

                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }

            return Disposables.create { task.cancel() }
        }.map { tickers -> [String: [Ticker]] in
                tickers.reduce(into: [String: [Ticker]]()) { partialResult, ticker in
                    if var certainTickers = partialResult[ticker.name] {
                        certainTickers.append(ticker)
                        partialResult[ticker.name] = certainTickers
                    } else {
                        partialResult[ticker.name] = [ticker]
                    }
                }
            }.flatMapLatest { tickersByName -> Observable<[Ticker]> in
                let result = tickersByName.keys.sorted(by: <).compactMap({ tickersByName[$0]?.first })
                return Observable<Int>.interval(.milliseconds(1000), scheduler: scheduler)
                    .map { _ in
                        result.compactMap { ticker -> Ticker in
                            let storedTickers = tickersByName[ticker.name] ?? []
                            let randomIndex = Int.random(in: 0..<storedTickers.count)
                            return storedTickers[randomIndex]
                        }
                    }
            }
            .subscribe(subject)
            .disposed(by: bag)
        
        self.subject = subject
        self.scheduler = scheduler
    }
    
}
