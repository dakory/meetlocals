//
//  LoadingModuleViewController.swift
//  meetlocals
//
//  Created by Dmitry Koryakin on 05.01.2021.
//  
//

import UIKit

final class LoadingModuleViewController: UIViewController {
	private let output: LoadingModuleViewOutput

    init(output: LoadingModuleViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.output.onLoadingView()
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor(rgb: 0xFAFAFA)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let indicator = UIActivityIndicatorView.init(style: .large)
        indicator.startAnimating()
        indicator.center = self.view.center
        view.addSubview(indicator)
    }
}

extension LoadingModuleViewController: LoadingModuleViewInput {
}
