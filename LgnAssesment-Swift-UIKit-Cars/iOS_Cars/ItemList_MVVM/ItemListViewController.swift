//
//  ItemListViewController.swift
//  LgnAssesment-Swift-UIKit-Cars
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

/// it is the MAIN controller - list of items
/// based on MVVM
/// ItemListModel - ItemListViewController - ItemListViewController
///
///  the cell view implemented in ItemViewCell
///
/// the details browsing implemented in CarouselViewController
///
/// here are two data types :
/// CarsListItem - data type fro data that comes from server-side
/// ItemDataModel - dat type that is used on UI
/// ItemDataMapperProtocol - is the mediator between CarsListItem and ItemDataModel
/// ItemDataMapperProtocol is used fro the app and for UnitTest
///
/// NetworkService provides request to server side and get results fro the app


import UIKit
import Combine

fileprivate typealias ItemsDataSource  = UICollectionViewDiffableDataSource<ItemListViewController.Section, ItemDataModel>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ItemListViewController.Section, ItemDataModel>


class ItemListViewController: UIViewController {

    let cellId = "cellId"
    private var viewModel: ItemListViewModel
    private var dataSource: ItemsDataSource!
    private var collectionView: UICollectionView! = nil

    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bag = Set<AnyCancellable>()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Items List"

        configureHierarchy()
        configureDataSource()
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        
        binding()
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.resetItemsList()
    }
    
    func binding() {
        @MainActor
        let _ = self.viewModel.$model.map{ $0 }.sink(receiveValue: { [weak self] _ in
            self?.updateSnashot()
        }).store(in: &bag)
    }
    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        viewModel.resetItemsList()
        refreshControl.endRefreshing()
    }

}


//MARK: - SetUp collectionView
extension ItemListViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
         collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
         collectionView.delegate = self
         collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         collectionView.backgroundColor = .systemBackground
         collectionView.register(ItemViewCell.self, forCellWithReuseIdentifier: cellId)
         view.addSubview(collectionView)
     }
    
    private func configureDataSource() {
        dataSource = ItemsDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> ItemViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ItemViewCell
            cell.item = item
            return cell
        })
        
        updateSnashot()
    }
    
    @MainActor
    fileprivate func updateSnashot() {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(self.viewModel.itemsList)
        DispatchQueue.main.async(execute: {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        })

    }

}

//MARK: - Collection View Delegates
extension ItemListViewController: UICollectionViewDelegate  {
    fileprivate enum Section {
        case main
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         collectionView.deselectItem(at: indexPath, animated: true)
         guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
         
         let viewModel = ItemViewModel(model: ItemModel(item: item))

         let cellViewController = CarouselViewController(viewModel: viewModel)
         
         self.navigationController?.pushViewController(cellViewController, animated: true)
     }
}
