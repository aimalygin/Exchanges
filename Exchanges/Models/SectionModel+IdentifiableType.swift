//
//  SectionModel+IdentifiableType.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import RxDataSources

extension SectionModel: AnimatableSectionModelType, IdentifiableType {

    init(original: SectionModel, items: [Item]) {
        self = original
        self.items = items
    }

    var identity: Section {
        sectionType
    }
}
