//
//  LastNewsViewCell.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import UIKit
import PinLayout
import RxCocoa
import RxSwift

class LastNewsViewCell: DisposeableViewCell {
    
    private let title: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        setupTitle()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: LastNewsViewModel) {
        viewModel.image.drive(imageView.rx.image)
            .disposed(by: bag)
        
        title.text = viewModel.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.pin.top().bottom(80%).right().left()
        imageView.pin.top(20%).bottom().right().left()
    }
    
    private func setupTitle() {
        title.numberOfLines = 2
        addSubview(title)
    }
    
    private func setupImageView() {
        addSubview(imageView)
    }
}
