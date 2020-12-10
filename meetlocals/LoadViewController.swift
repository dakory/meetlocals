//
//  LoadViewController.swift
//  meetlocals
//
//  Created by Danil Ilichev on 10.12.2020.
//

import UIKit

class LoadViewController: UIViewController {

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indicator = UIActivityIndicatorView.init(style: .large)
        indicator.startAnimating()
        indicator.center = self.view.center
        view.addSubview(indicator)
    }
}
