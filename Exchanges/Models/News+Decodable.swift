//
//  News+Decodable.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation

extension News {
    enum CodingKeys: String, CodingKey {
        case title, description
        case date = "publishedAt"
        case imageUrl = "urlToImage"
    }
    
    enum NewsParsingError: Error {
        case invalidDateFormat
    }
    
    static let dateFormatter: ISO8601DateFormatter = {
        ISO8601DateFormatter()
    }()
}

extension News: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        let dateString = try container.decode(String.self, forKey: .date)
        if let parsedDate = News.dateFormatter.date(from: dateString) {
            date = parsedDate
        } else {
            throw NewsParsingError.invalidDateFormat
        }
        imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        description = try container.decode(String.self, forKey: .description)
    }
}
