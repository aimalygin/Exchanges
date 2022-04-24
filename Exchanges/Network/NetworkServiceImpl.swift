//
//  NetworkServiceImpl.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import Foundation
import Alamofire
import CSV

final class NetworkServiceImpl: NetworkService {
    
    struct Configuration {
        let tickersUrl: String
        let newsUrl: String
        
        static func `default`() -> Configuration {
            Configuration(
                tickersUrl: "https://raw.githubusercontent.com/dsancov/TestData/main/stocks.csv",
                newsUrl: "https://saurav.tech/NewsAPI/everything/cnn.json"
            )
        }
    }
    
    struct Response: Decodable {
        let status: String
        let totalResults: Int
        let articles: [News]
        
        enum CodingKeys: String, CodingKey {
            case status, totalResults, articles
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            status = try container.decode(String.self, forKey: .status)
            totalResults = try container.decode(Int.self, forKey: .totalResults)
            articles = try container.decode(LossyDecodableList<News>.self, forKey: .articles).elements
        }
    }
    
    private let config: Configuration
    
    init(config: Configuration = Configuration.default()) {
        self.config = config
    }
    
    func getTickers() async throws -> [Ticker] {
        let request = AF.request(config.tickersUrl).serializingString()
        let csv = try await CSVReader(string: request.value, hasHeaderRow: true, trimFields: true)
        var result: [Ticker] = []
        while csv.next() != nil {
            if let stockName = csv["STOCK"],
                let priceString = csv["PRICE"],
                let price = Double(priceString) {
                
                result.append(Ticker(name: stockName, price: price))
            }
        }
        return result
    }
    
    func getNews() async throws -> [News] {
        do {
            let request = AF.request(config.newsUrl).serializingDecodable(Response.self)
            return try await request.value.articles
        } catch {
            print(String(describing: error))
            return []
        }
    }
    
    
}

struct LossyDecodableList<Element> {
    var elements: [Element]
}

extension LossyDecodableList: Decodable where Element: Decodable {
    private struct ElementWrapper: Decodable {
        var element: Element?

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            element = try? container.decode(Element.self)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let wrappers = try container.decode([ElementWrapper].self)
        elements = wrappers.compactMap(\.element)
    }
}
