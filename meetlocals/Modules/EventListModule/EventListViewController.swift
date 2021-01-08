//
//  EventListViewController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class EventListController: UIViewController, UISearchBarDelegate{
    private let output: EventListViewOutput
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: CollectionViewFlowLayout())
    private var viewModels = [EventViewModel]()
    private var isCommon: Bool = false

    
    init(output: EventListViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
    
    override func loadView() {
        let view = UIView()
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        navigationController?.view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        self.view = view
        setupView()
        self.navigationController?.navigationBar.prefersLargeTitles = !isCommon
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        attemptToHideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = !isCommon
    }
    
    private func attemptToHideKeyboard() {
        self.navigationItem.searchController?.searchBar.resignFirstResponder()
        self.navigationItem.searchController?.searchBar.endEditing(true)
        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        self.hideKeyboardWhenTappedAround()
        UINavigationBar.appearance().shadowImage = UIImage()
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
                let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
                let titleImageView = UIImageView(image: UIImage(named: "promoIcon"))
                titleImageView.frame = CGRect(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
                titleView.addSubview(titleImageView)
                titleView.clipsToBounds = true
                titleView.contentMode = .scaleAspectFill
                return titleView
            }()
            makeSearchController()
            isCommon = true
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
        attemptToHideKeyboard()
        self.output.didTabEvent(meetingID: cell.eventId)
        self.viewDidLoad()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.output.reloadEventsWithTheSearch(text: searchText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.output.viewDidLoad()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        attemptToHideKeyboard()
    }

}

extension EventListController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
}
    
    
private extension EventListController {
    func setupView() {
        self.collectionView.clipsToBounds = false
        self.collectionView.backgroundColor = view.backgroundColor
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    
    func makeSearchController() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.delegate = self
        
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.searchBar.showsCancelButton = false
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.searchController?.searchBar.placeholder = "Поиск"
        navigationItem.searchController?.searchBar.backgroundColor = #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998806119, alpha: 1)
    }
}
