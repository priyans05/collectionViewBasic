//
//  ViewController.swift
//  collectionView
//
//  Created by PRIYANS on 20/12/19.
//  Copyright © 2019 PRIYANS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.collectionViewLayout = configureLayout()
        configureDataSource()
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.20), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let collectionViewSection = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: collectionViewSection)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
                fatalError("Not able to create a cell")
            }
            cell.label.text = number.description
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true

            return cell
        })
        
        var initialSnapShot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapShot.appendSections([.main])
        initialSnapShot.appendItems(Array(1...100))
        
        dataSource.apply(initialSnapShot, animatingDifferences: true, completion: nil)
    }

}

