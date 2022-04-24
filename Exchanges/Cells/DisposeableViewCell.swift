//
//  DisposeableViewCell.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import UIKit
import RxSwift

class DisposeableViewCell: UICollectionViewCell {
    
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = DisposeBag()
    }
    
}
