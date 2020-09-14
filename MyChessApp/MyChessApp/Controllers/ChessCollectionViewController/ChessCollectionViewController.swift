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
    @IBOutlet weak var viewPathsButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    private var data: ChessModel
    private var chessService: ChessService

    init(data: ChessModel) {
        self.data = data
        chessService = ChessServiceImpl.init(data: data)
        super.init(nibName: "ChessCollectionViewController", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewPathsButton.isHidden = true
        resetButton.isHidden = true
        setupCollectionView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        self.navigationItem.title = String(describing: type(of: self))
    }

    /// Setup collection view
    private func setupCollectionView() {
        collectionView.isHidden = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        let nib = UINib.init(nibName: "ChessCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = UIColor.black.cgColor
    }

    /// Reset data
    private func resetData() {
        resetButton.isHidden = true
        viewPathsButton.isHidden = true
        data.sourcePosition = nil
        data.destinationPosition = nil
        data.results = nil
    }

    /// Reset data
    private func showNoPathError() {
        let alert = UIAlertController(title: "Chess",
                                      message: "It looks like there are no paths for the chosen destination.\n Try again",
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Reset",
                                        style: .default,
                                        handler: { [weak self] _ in
                                            guard let strongSelf = self else { return }

                                            strongSelf.resetData()
                                            strongSelf.collectionView.reloadData()
        })

        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }

    @IBAction func viewPathsPressed(_ sender: Any) {
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        resetData()
        collectionView.reloadData()
    }
}

extension ChessCollectionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        if data.sourcePosition == nil {
            data.sourcePosition = Node.init(x: indexPath.row, y: indexPath.section)
            chessService.updateData(data: data)
            resetButton.isHidden = false
            collectionView.reloadData()
        } else if data.destinationPosition == nil &&
            data.destinationPosition != data.sourcePosition {
            data.destinationPosition = Node.init(x: indexPath.row, y: indexPath.section)
            chessService.updateData(data: data)
            if let results = chessService.validateData(),
                results.count > 0 {
                data.results = results
                collectionView.reloadData()
                viewPathsButton.isHidden = false
            } else {
                showNoPathError()
            }
        }
    }
}

extension ChessCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: Int = data.size ?? 0
        let width = collectionView.frame.size.width/CGFloat(size)
        let height = collectionView.frame.size.height/CGFloat(size)
        return CGSize(width: width, height: height)
    }
}

extension ChessCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.size ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.size ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",
                                                           for: indexPath) as! ChessCollectionViewCell

        if let horizontalCharachter = Int(indexPath.row+1).associatedCharacter {
            let displayText = String(format: "%@ - %@", String(indexPath.section+1), horizontalCharachter)
            cell.positionInfo.text =  displayText
        } else {
            cell.positionInfo.text =  String(indexPath.section) + ":" + String(indexPath.row)
        }

        cell.knightImage.isHidden = chessService.shouldShowKnightImage(at: indexPath)
        cell.backgroundColor = chessService.getBackgroundColor(at: indexPath)
        cell.positionInfo.textColor = chessService.getTextColorForCell(at: indexPath)
        return cell
    }
}
