//
//  ProfileModuleViewController.swift
//  ProfileModule
//
//  Created by Dmitry Koryakin on 28.10.2020.
//  
//

import UIKit

final class ProfileModuleViewController: UIViewController {
    private let output: ProfileModuleViewOutput
    private var profileModuleView: ProfileModuleView {
        self.view as! ProfileModuleView
    }

    init(output: ProfileModuleViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = ProfileModuleView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"

    }
}

extension ProfileModuleViewController: ProfileModuleViewInput {
}

final class ProfileModuleView: AutoLayoutView {

    private let userAvatarImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let userAgeLabel = UILabel()
    private let inviteButton = UIButton()

    init() {
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(self.userAvatarImageView)
        self.addSubview(self.userNameLabel)
        self.addSubview(self.userAgeLabel)
        self.addSubview(self.inviteButton)

        self.backgroundColor = .white

        self.userAvatarImageView.image = UIImage(named: "userAvatar")
        self.userAvatarImageView.contentMode = UIImageView.ContentMode.scaleAspectFill

        self.userNameLabel.text = "Dmitry Koryakin"
        self.userNameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        self.userNameLabel.numberOfLines = 0

        self.userAgeLabel.text = "22 years old"
        self.userAgeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.userAgeLabel.numberOfLines = 1
        self.userAgeLabel.textColor = .darkGray

        self.inviteButton.setTitle("Пригласить", for: .normal)
        self.inviteButton.backgroundColor = .systemBlue
        self.inviteButton.layer.cornerRadius = 30

    }

    override func setupConstraints() {
        super.setupConstraints()

        [
            self.userAvatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .topAnchor, constant: 16),
            self.userAvatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .leadingAnchor, constant: 16),
            self.userAvatarImageView.heightAnchor.constraint(equalToConstant: 100),
            self.userAvatarImageView.widthAnchor.constraint(equalToConstant: 100),

            self.userNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .topAnchor, constant: 36),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.userAvatarImageView
                    .trailingAnchor, constant: 24),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .trailingAnchor, constant: -16),

            self.userAgeLabel.topAnchor.constraint(equalTo: self.userNameLabel
                    .bottomAnchor, constant: 8),
            self.userAgeLabel.leadingAnchor.constraint(equalTo: self.userNameLabel
                    .leadingAnchor),
            self.userAgeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .trailingAnchor, constant: -16),

            self.inviteButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .bottomAnchor),
            self.inviteButton.heightAnchor.constraint(equalToConstant: 60),
            self.inviteButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .leadingAnchor, constant: 16),
            self.inviteButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide
                    .trailingAnchor, constant: -16),


        ].forEach {
            $0.isActive = true
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.userAvatarImageView.setRounded()
    }
}

