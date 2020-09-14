//
//  ChessCollectionViewController.swift
//  MyChessApp
//
//  Created by John Platsis on 13/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ChessCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationItem.title = String(describing: type(of: self))

//
    }

    /// Setup collection view
    private func setupCollectionView() {
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        let nib = UINib.init(nibName: "ChessCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCell")
    }

}

extension ChessCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

//
    }
}

extension ChessCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

//
        return CGSize(width: 0, height: 0)
    }
}

extension ChessCollectionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
        return 0

    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
//
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//
        return UICollectionViewCell()
    }
}
