//
//  ProfileModuleViewController.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import UIKit

final class ProfileModuleViewController: UIViewController {
    let imageOfPerson = UIImageView()
    let nameOfPerson = UILabel()
    
    let stackViewTopLabel = UIStackView()
    
    let scrollView = UIScrollView()
    let buttonExit = UIButton()

    
    private let output: ProfileModuleViewOutput

    init(output: ProfileModuleViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        output.getData()
        
        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        self.scrollView.addSubview(imageOfPerson)
        self.scrollView.addSubview(nameOfPerson)
        self.scrollView.addSubview(buttonExit)
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem =
           UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.circle"),
            tag: 3)
        self.navigationItem.title = "Профиль"

        
    }
    
    func setupConstraints() {
        self.imageOfPerson.translatesAutoresizingMaskIntoConstraints = false
        self.nameOfPerson.translatesAutoresizingMaskIntoConstraints = false
        self.buttonExit.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
        ].forEach({
            $0.isActive = true
        })
    
        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.layer.cornerRadius = 35
        imageOfPerson.clipsToBounds = true
        
        
        
        nameOfPerson.font = nameOfPerson.font.withSize(16)
        nameOfPerson.numberOfLines = 0

            
        imageOfPerson.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 229).isActive = true
        imageOfPerson.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -60).isActive = true
        imageOfPerson.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 60).isActive = true
        imageOfPerson.bottomAnchor.constraint(equalTo: imageOfPerson.topAnchor, constant: 120).isActive = true
        
        nameOfPerson.topAnchor.constraint(equalTo: imageOfPerson.bottomAnchor, constant: 26).isActive = true
        nameOfPerson.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        nameOfPerson.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        nameOfPerson.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        nameOfPerson.textAlignment = NSTextAlignment.center
        
        buttonExit.setTitle("Выйти", for: .normal)
        buttonExit.titleLabel?.font.withSize(17)
        buttonExit.backgroundColor = #colorLiteral(red: 0.9139195085, green: 0.2209282517, blue: 0.7613213658, alpha: 1)
        
        buttonExit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32).isActive = true
        buttonExit.topAnchor.constraint(equalTo: buttonExit.bottomAnchor, constant: -47).isActive = true
        buttonExit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37).isActive = true
        buttonExit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37).isActive = true
        buttonExit.layer.cornerRadius = 24
        buttonExit.addTarget(self, action: #selector(didTapButtonExit), for: .touchUpInside)
    }
    
    @objc
    func didTapButtonExit() {
        output.didTapButtonExit()
    }
}

extension ProfileModuleViewController: ProfileModuleViewInput {
    
    func setProfileData(person: Profile) {
        nameOfPerson.text = "\(person.name) \(person.surname)"
        imageOfPerson.image =  UIImage(named: person.avatarUrl!)
    }
}

