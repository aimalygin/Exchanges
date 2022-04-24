//
//  TickerViewCell.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import UIKit

class TickerViewCell: UICollectionViewCell {
    
    private let name: UILabel = UILabel()
    private let price: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(name)
        addSubview(price)
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        name.pin.top().bottom(20).left().right()
        price.pin.top(25).bottom().left().right()
    }
    
    func bind(viewModel: TickerViewModel) {
        name.text = viewModel.name
        price.text = viewModel.price
    }
}
