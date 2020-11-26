//
//  EventListViewController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListController: UIViewController {
    private let output: EventListViewOutput
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 65, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CollectionViewFlowLayout())
 //   private let buttonAddEvent = UIButton(type: .custom)
    private var viewModels = [EventViewModel]()

    
    init(output: EventListViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    
    override func loadView() {
        let view = UIView()
        view.addSubview(self.collectionView)
    //    view.addSubview(self.buttonAddEvent)
        view.backgroundColor = .white
        self.view = view
        setupCollectionView()
 
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let collectionViewFrameTopOffset: CGFloat = 65
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
        self.navigationItem.title = "Лента"
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
            self.navigationItem.title = "Лента"
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
    func setupCollectionView() {
        
        self.collectionView.clipsToBounds = true
        self.collectionView.backgroundColor = view.backgroundColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }

//    func setupButtonAddEvent() {
//        self.buttonAddEvent.translatesAutoresizingMaskIntoConstraints = false
//        self.buttonAddEvent.backgroundColor = .blue
//        self.buttonAddEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
//        self.buttonAddEvent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
//        self.buttonAddEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.height/8).isActive = true
//        self.buttonAddEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIScreen.main.bounds.height/8).isActive = true
//
//        self.buttonAddEvent.setImage(UIImage(named: "plus"), for: .normal)
//        self.buttonAddEvent.layer.cornerRadius = UIScreen.main.bounds.height / 20
//        self.buttonAddEvent.clipsToBounds = true
//    }
    
//    @objc
//    func didTapButtonAddEvent() {
//        self.output.didTabAddEvent()
//    }
}
