//
//  UICollectionView+Extension.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func dequeueReusableCell<Cell>(with type: Cell.Type, for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: type)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
        else {
            fatalError("Cell is nil")
        }
        return cell
        
    }
    
    func register(_ cellClass: AnyClass) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
}
