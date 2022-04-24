//
//  NewsViewCell.swift
//  Exchanges
//
//  Created by Anton Malygin on 24.04.2022.
//

import UIKit
import RxCocoa
import RxSwift
import PinLayout

class NewsViewCell: DisposeableViewCell {
    
    private let title: UILabel = UILabel()
    private let dateLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    private static let margin: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        setupTitle()
        setupDateLabel()
        setupDescriptionLabel()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(viewModel: NewsViewModel) {
        
        viewModel.image.debug().drive(imageView.rx.image)
            .disposed(by: bag)
        
        title.text = viewModel.title
        dateLabel.text = viewModel.dateString
        descriptionLabel.text = viewModel.description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        title.pin.top().right().left().height(50)
        dateLabel.pin.below(of: title).marginTop(Self.margin).left().right().height(30)
        imageView.pin.below(of: dateLabel).marginTop(Self.margin).left().right().height(200)
        descriptionLabel.pin.below(of: imageView).marginTop(Self.margin).left().right().bottom()
    }
    
    private func setupTitle() {
        title.numberOfLines = 2
        addSubview(title)
    }
    
    private func setupDateLabel() {
        dateLabel.font = .systemFont(ofSize: 11)
        addSubview(dateLabel)
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        addSubview(descriptionLabel)
    }
    
    private func setupImageView() {
        addSubview(imageView)
    }
}
