//
//  FavoriteEventsViewController.swift
//  meetlocals
//
//  Created by Danil Ilichev on 15.11.2020.
//  
//

import UIKit

final class FavoriteEventsViewController: UIViewController {
	private let output: FavoriteEventsViewOutput

    init(output: FavoriteEventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.tabBarItem =
           UITabBarItem(
            title: "Избранное",
            image: UIImage(systemName: "star"),
            tag: 1)
        self.navigationItem.title = "Избранное"

        self.view.backgroundColor = .white
	}
}

extension FavoriteEventsViewController: FavoriteEventsViewInput {
}
