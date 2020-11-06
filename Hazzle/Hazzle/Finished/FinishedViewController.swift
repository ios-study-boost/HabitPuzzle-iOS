//
//  FinishedViewController.swift
//  Hazzle
//
//  Created by 이지원 on 2020/10/23.

import UIKit

class FinishedViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Configuare
extension FinishedViewController {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FinishedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FinishedCell")
    }
    func configureCollectionViewLayout() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 5
        let padding  = flowLayout.sectionInset.left*2
        let widthPerItem = UIScreen.main.bounds.width/2 - padding
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem+50)
        self.collectionView.collectionViewLayout = flowLayout
    }
}
// MARK: - CollectionView DataSource
extension FinishedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FinishedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FinishedCollectionViewCell.cellIdentifier, for: indexPath) as? FinishedCollectionViewCell else {return UICollectionViewCell()}
        cell.finishedImage.image = UIImage(named: "testImage")
        return cell
    }
}
// MARK: - CollectionView Delegate
extension FinishedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC: HabitDetailViewController = HabitDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
