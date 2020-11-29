//
//  EventListViewController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListController: UIViewController {
    private let output: EventListViewOutput
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CollectionViewFlowLayout())
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
        view.backgroundColor = UIColor(hexString: "#E5E5E5")
        self.view = view
        setupCollectionView()
 
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let collectionViewFrameTopOffset: CGFloat = 100
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
    func setupCollectionView() {
        
        self.collectionView.clipsToBounds = true
        self.collectionView.backgroundColor = view.backgroundColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
