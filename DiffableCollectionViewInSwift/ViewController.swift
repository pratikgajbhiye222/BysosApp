//
//  ViewController.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import UIKit
import Foundation
//import SoftUIView

class ViewController: UIViewController, UICollectionViewDelegate {
    
    typealias SnapShotdataSource = NSDiffableDataSourceSnapshot<SectionLayout, DataForContest>
   typealias DataSource = UICollectionViewDiffableDataSource<SectionLayout, DataForContest>
   private var dataSource: DataSource!
    var snapShotRebel = SnapShotdataSource()
   
   var model2 = [DataForContest]()
   
   //MARK:- Properties
   var content : DataForContest!
//    var dataSource: UICollectionViewDiffableDataSource<SectionLayout, DataForContest>! = nil
   var collectionView: UICollectionView! = nil
   let primaryColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
 
   
   //for Sliding
   var timer : Timer?
   var currentCellIndex : Int = 0
   override func viewDidLoad() {
       super.viewDidLoad()
       setUpView()
       self.navigationController?.navigationBar.tintColor = UIColor.white
       
       configurationOfdataSource()
       setupCellAndSupplementaryRegistrations()
       _ = APIClient.getContestListForHomePage(completion: { (response, success, error) in
           print(response)
           print(self.model2)
           print(error)
           print(response.data)
           print(response.data?.contests)
//            model2.append(response.data!)
           for item in [response.data] {
               self.model2.append(item!)
           }
           DispatchQueue.main.async {
               self.applySnapShotRebel(model: response.data!)
           }
          
       })
       
   }
   
   override func viewWillLayoutSubviews() {
       super.viewWillLayoutSubviews()
       setUpView()
   }
   
   private func setUpView() {
       self.view.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
       setupCollectionView()
   }
   //MARK: - Collection View
   private func setupCollectionView()  {
       // Initialises the collection view with a CollectionViewLayout which we will define
       configureHierarchy()
//        configureDataSource()
       collectionView.backgroundColor =  UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
       // Adding the collection view to the view
       view.addSubview(collectionView)
       //collection View Delegate
       collectionView.delegate = self
       
       // This line tells the system we will define our own constraints
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       collectionView.scrollsToTop = false
       // Constraining the collection view to the 4 edges of the view
       NSLayoutConstraint.activate([
           collectionView.topAnchor.constraint(equalTo: view.topAnchor),
           collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
       ])
       
   }
   var bannerCellRegistration: UICollectionView.CellRegistration<BannerCell, DataForContest>!
   
   var contestCellRegistration: UICollectionView.CellRegistration<contestCollectionCell, DataForContest>!
   
  
   var avatarCellRegistration: UICollectionView.CellRegistration<AvatarCell, DataForContest>!
   var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
   var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!
   
   func configureHierarchy() {
       collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
       collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       collectionView.backgroundColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1.0)
       view.addSubview(collectionView)
   }
   
   func createLayout() -> UICollectionViewLayout {
       UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
           let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
           
           switch sectionIdentifier {
           case .storiesCarousel:
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.85), heightDimension: .estimated(1)), subitems: [item])
               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = 16
               section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
               section.orthogonalScrollingBehavior = .continuous
               section.supplementariesFollowContentInsets = false
               section.boundarySupplementaryItems = [self.supplementaryHeaderItem() , self.supplementarySeparatorFooterItem()]
               return section
               
           case .bannerCarousel :
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(75)))
               let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(75)), subitems: [item])
               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = 9
               section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
               section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
               section.supplementariesFollowContentInsets = false
               return section
               
           case .contestCarousel :
               let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
               let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.001), heightDimension: .estimated(1)), subitems: [item])
               let section = NSCollectionLayoutSection(group: group)
               section.interGroupSpacing = 16
               section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
               section.orthogonalScrollingBehavior = .none
               section.supplementariesFollowContentInsets = false
               section.boundarySupplementaryItems = [self.supplementaryHeaderItem() , self.supplementarySeparatorFooterItem()]
               return section
               
           default:
               return nil
           }
       }
   }
   
   
   func setupCellAndSupplementaryRegistrations() {
       bannerCellRegistration = .init(cellNib: BannerCell.nib, handler: { (cell, _, item) in
           cell.setup(item)
           
       })
       
       contestCellRegistration = .init(cellNib: contestCollectionCell.nib, handler: { (cell, _, item) in
           cell.setup(item)
           
       })
       
       avatarCellRegistration = .init(cellNib: AvatarCell.nib, handler: { (cell, indexPath, item) in
           cell.setup(item: item)
       })
           
       headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in
//            let title = self.backingStore[indexPath.section].title
//            header.titleLabel.text = title
//            let title = ["A","B","C"]
           let sectionKind = SectionLayout(rawValue: indexPath.section)
           header.titleLabel.text = sectionKind?.sectionTitle
           
       })
       
       footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
   }
   
   private func supplementaryHeaderItem() ->NSCollectionLayoutBoundarySupplementaryItem {
       NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader , alignment: .top)
   }
   private func supplementarySeparatorFooterItem() ->NSCollectionLayoutBoundarySupplementaryItem {
       NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .absolute(1), heightDimension: .absolute(1)), elementKind: UICollectionView.elementKindSectionFooter , alignment: .bottom)
   }
//    func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<SectionLayout, DataForContest>(collectionView: collectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, item: DataForContest) -> UICollectionViewCell? in
//            guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: item) else {
//                return nil
//            }
//            switch sectionIdentifier {
//            case .bannerCarousel:
//                return collectionView.dequeueConfiguredReusableCell(using: self.bannerCellRegistration, for: indexPath, item: item)
//            case .storiesCarousel:
//                return collectionView.dequeueConfiguredReusableCell(using: self.avatarCellRegistration, for: indexPath, item: item)
//            case .contestCarousel:
//                return collectionView.dequeueConfiguredReusableCell(using: self.contestCellRegistration, for: indexPath, item: item)
//            }
//        }
//        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
//            if kind == UICollectionView.elementKindSectionHeader {
//                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
//            } else {
//                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
//            }
//        }
//    }
   
   @objc func createPortFolioAction() {
      
       }
   
   
   
//}
//extension OpeningBellViewController : UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
       print("This is \(item)")
   }
   
   private func configurationOfdataSource() {
       dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, response) -> UICollectionViewCell? in
           guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: response) else {
               return nil
           }
           switch sectionIdentifier {
           case .storiesCarousel:
               return collectionView.dequeueConfiguredReusableCell(using: self.avatarCellRegistration, for: indexPath, item: response)
           case .bannerCarousel:
               return collectionView.dequeueConfiguredReusableCell(using: self.bannerCellRegistration, for: indexPath, item: response)
           case .contestCarousel:
               return collectionView.dequeueConfiguredReusableCell(using: self.contestCellRegistration, for: indexPath, item: response)
           }
       })
       
       dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
           if kind == UICollectionView.elementKindSectionHeader {
               return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
           } else {
               return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
           }
       }
       
       
   }
   
   private func applySnapShotRebel(model: DataForContest) {
       snapShotRebel = dataSource.snapshot()
       snapShotRebel.appendSections([.storiesCarousel, .bannerCarousel , .contestCarousel])
    model2.append(model)
       snapShotRebel.appendItems(model2, toSection: .storiesCarousel)
       
       snapShotRebel.appendItems(model2, toSection: .bannerCarousel)
       
       snapShotRebel.appendItems(model2, toSection: .contestCarousel)
       print(snapShotRebel)
       print(snapShotRebel.itemIdentifiers)
       dataSource.apply(snapShotRebel,animatingDifferences: true)
       print(dataSource)
       print(snapShotRebel.sectionIdentifiers)
   }
   
}




class SectionHeaderTextReusableView: UICollectionReusableView {
    
    static var nib: UINib {
        UINib(nibName: "SectionHeaderTextReusableView", bundle: nil)
    }
        
    @IBOutlet weak var titleLabel: UILabel!
}


class SeparatorCollectionReusableView: UICollectionReusableView {
    
    let separatorView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {
        addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        let inset = CGFloat(16)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            separatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        separatorView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
    }
    
    
}
