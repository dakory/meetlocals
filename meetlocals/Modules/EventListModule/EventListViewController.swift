//
//  EventListViewController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListController: UIViewController {
    private let output: EventListViewOutput
    let collectionViewFrameTopOffset: CGFloat = 20
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CollectionViewFlowLayout())
    let scrollView = UIScrollView()
    private var viewModels = [EventViewModel]()

    
    init(output: EventListViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    
    override func loadView() {
        let view = UIView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(self.scrollView)
        self.scrollView.addSubview(collectionView)
        view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        self.view = view
        setupView()
 
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = CGRect(
            x: 0,
            y: collectionViewFrameTopOffset,
            width: self.view.frame.width,
            height: self.view.frame.height - collectionViewFrameTopOffset)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem =
           UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        self.output.viewDidLoad()
        
    }
    
}

extension EventListController: EventListViewInput {
    func updateList() {
        self.output.viewDidLoad()
    }
    
    
    func set(viewModels: [EventViewModel]) {
        self.viewModels = viewModels
        self.collectionView.reloadData()
    }
    
    func selectingScreenListType(type: TypeOfListScreen){
        if type == .common {
            self.tabBarItem =
               UITabBarItem(
                title: "Лента",
                image: UIImage(systemName: "magnifyingglass"),
                tag: 0)
            self.navigationItem.titleView = {
                let titleView = UIView(frame: CGRect(x: view.safeAreaInsets.top + 10, y: 0, width: 90, height: 30))
                let titleImageView = UIImageView(image: UIImage(named: "promoIcon"))
                titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
                titleView.addSubview(titleImageView)
                titleView.clipsToBounds = true
                titleView.contentMode = .scaleAspectFill
                return titleView
                
            }()
        }
        else if type == .participating {
            self.tabBarItem =
               UITabBarItem(
                title: "Участвую",
                image: UIImage(systemName: "person.2.fill"),
                tag: 1)
            self.navigationItem.title = "Участвую"
        }
        else {
            self.tabBarItem =
               UITabBarItem(
                title: "Организую",
                image: UIImage(systemName: "text.badge.plus"),
                tag: 2)
            self.navigationItem.title = "Организую"
        }
    }



}

extension EventListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: self.viewModels[indexPath.row], collectionView: collectionView, index: indexPath.row)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.layer.shadowRadius = cell.layer.cornerRadius
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowColor = UIColor.gray.cgColor

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) -> () {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.output.didTabEvent(meetingID: cell.eventId)
    }
    
}

extension EventListController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
}
    
    
private extension EventListController {
    func setupView() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ].forEach({
            $0.isActive = true
        })

        self.collectionView.clipsToBounds = true
        self.collectionView.backgroundColor = view.backgroundColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
}
