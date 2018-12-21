//
//  HomeViewController.swift
//  TMDb
//
//  Created by Daniel Mankowski on 16/12/2018.
//  Copyright © 2018 Daniel Mankowski. All rights reserved.
//

import UIKit

protocol HomeViewControllable {
    func updateCollection(indexes: [IndexPath]?)
}

protocol HomeViewControllerListener: class {
    func numberOfMovies() -> Int
    func isLoadingCell(for index: IndexPath) -> Bool
    func getMovie(index: IndexPath) -> Movie?
    func didTapCell(index: IndexPath)
    func fetchMovies(query: String?)
}

final class HomeViewController: ViewController, HomeViewControllable {
    
    weak var listener: HomeViewControllerListener?
    
    private let sectionInsets = UIEdgeInsets(top: 8.0, left: 10.0, bottom: 8.0, right: 10.0)
    private var itemsPerRow: CGFloat = 2

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
    func updateCollection(indexes: [IndexPath]?) {
        DispatchQueue.main.async {
            if let indexes = indexes {
                self.collectionView.reloadItems(at: indexes)
            } else {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupInterface() {
        searchBar.barTintColor = .blue
        title = "TMDb upcoming movies"
    }
}

//MARK:- UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        listener?.fetchMovies(query: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        listener?.fetchMovies(query: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty ?? true {
            listener?.fetchMovies(query: nil)
        }
    }
}

//MARK:- UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listener?.didTapCell(index: indexPath)
    }
}

//MARK:- UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        guard !(listener?.isLoadingCell(for: indexPath) ?? true) else { return cell }
        guard let movie = listener?.getMovie(index: indexPath) else { return UICollectionViewCell() }
        cell.model = MovieCollectionViewCell.Model(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listener?.numberOfMovies() ?? 0
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let height = widthPerItem + 80
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

//MARK:- UICollectionViewDataSourcePrefetching
extension HomeViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { (index) -> Bool in
            listener?.isLoadingCell(for: index) ?? false
        }) {
            if searchBar.text?.isEmpty ?? true {
                listener?.fetchMovies(query: nil)
            } 
        }
    }
}
