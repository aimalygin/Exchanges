//
//  SectionModel.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation

struct SectionModel {

    var items: [Item]
    let sectionType: Section
    
    init(items: [Item] = [], sectionType: Section) {
        self.items = items
        self.sectionType = sectionType
    }
}
