//
//  ViewController.swift
//  Exchanges
//
//  Created by Anton Malygin on 22.04.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Swinject

class ViewController: UICollectionViewController {
    
    private let viewModel = Container.shared.resolve(ViewModel.self)!
    private let bag = DisposeBag()
    
    private let sectionInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
    private let groupInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        bindDataSource()
        
    }
    
    private func setupCollectionView() {
        collectionView.register(TickerViewCell.self)
        collectionView.register(LastNewsViewCell.self)
        collectionView.register(NewsViewCell.self)
        
        collectionView.collectionViewLayout = generateLayout()
        collectionView.dataSource = nil
        collectionView.delegate = nil
        collectionView.rx.setDelegate(self)
            .disposed(by: bag)
    }
    
    private func bindDataSource() {
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<SectionModel>(configureCell: { _, collectionView, indexPath, item in
            switch item {
            case let .ticker(viewModel):
                let cell = collectionView.dequeueReusableCell(with: TickerViewCell.self, for: indexPath)
                cell.bind(viewModel: viewModel)
                return cell
            case let .lastNews(viewModel):
                let cell = collectionView.dequeueReusableCell(with: LastNewsViewCell.self, for: indexPath)
                cell.bind(viewModel: viewModel)
                return cell
            case let .news(viewModel):
                let cell = collectionView.dequeueReusableCell(with: NewsViewCell.self, for: indexPath)
                cell.bind(viewModel: viewModel)
                return cell
            }
            
        })
                
        viewModel.sections
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }

    private func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .tickers:
                return self.tickersLayoutSection()
            case .lastNews:
                return self.lastNewsLayoutSection()
            case .otherNews:
                return self.otherNewsLayoutSection()
            }
        }
        return layout
    }
    
    private func tickersLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalWidth(1/4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = sectionInsets
        return section
    }
    
    private func lastNewsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = sectionInsets
        return section
    }
    
    private func otherNewsLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(1.1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitem: item, count: 1)
        group.contentInsets = groupInsets
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        return section
    }
    
}

