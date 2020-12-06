//
// Created by 17099611 on 17.11.2020.
//

import Foundation
import UIKit
import VK_ios_sdk

class MainViewController: UIViewController {

    var vkDelegate: VKSdkDelegate?
    var vkUiDelegate: VKSdkUIDelegate?

    private var mainView: MainView {
        self.view as! MainView
    }

    override func loadView() {
        super.loadView()

        self.view = MainView()
        self.view.backgroundColor = #colorLiteral(red: 0.9685224891, green: 0.9686880708, blue: 0.9685119987, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        mainView.authorizeButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }

    @objc
    public func authorize() {
        let vkUrl = VkInfo.VK_AUTHORIZATION_URL
        print(vkUrl)
        VKSdk.processOpen(vkUrl, fromApplication: VkInfo.APPLICATION_ID)
        initVkDelegates()
        VKSdk.wakeUpSession(VkInfo.PERMISSIONS, complete: signedIn)
        VKSdk.authorize(VkInfo.PERMISSIONS)
    }

    private func initVkDelegates() {
        vkDelegate = VkDelegate()
        vkUiDelegate = VkUiDelegate()
        let sdkInstance = VKSdk.initialize(withAppId: VkInfo.APPLICATION_ID)
        sdkInstance?.register(vkDelegate)
        sdkInstance?.uiDelegate = vkUiDelegate
    }

    private func clearDelegates() {
        vkDelegate = nil
        vkUiDelegate = nil
    }

    private func signedIn(state: VKAuthorizationState, error: Error!) {
        if (state == VKAuthorizationState.authorized) {

            print("User already has been authorized")
            print("Everything is cool!")

            //TODO открыть EventListModule
        } else if (state == VKAuthorizationState.error) {
            print("Some error happened")
        }
    }
}

class MainView: AutoLayoutView {

    let promoIconView = UIImageView()
    let welcomeTextView = UILabel()
    let authorizeButton = UIButton(type: .system)

    init() {
        super.init(frame: .zero)

        initViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupConstraints() {
        super.setupConstraints()

        [
            self.promoIconView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 300),
            self.promoIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 112),
            self.promoIconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -112),

            self.welcomeTextView.topAnchor.constraint(equalTo: self.promoIconView
                    .bottomAnchor, constant: 28),
            self.welcomeTextView.leadingAnchor.constraint(equalTo: self.promoIconView
                    .leadingAnchor),
            self.welcomeTextView.trailingAnchor.constraint(equalTo: self.promoIconView
                    .trailingAnchor),

            self.authorizeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            self.authorizeButton.heightAnchor.constraint(equalToConstant: 48),
            self.authorizeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 38),
            self.authorizeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -38)
        ].forEach {
            $0.isActive = true
        }
    }

    private func initViews() {
        self.addSubview(self.promoIconView)
        self.addSubview(self.welcomeTextView)
        self.addSubview(self.authorizeButton)

        self.backgroundColor = .white

        promoIconView.image = UIImage(named: "promoIcon")
        promoIconView.contentMode = UIImageView.ContentMode.scaleAspectFill

        welcomeTextView.text = "Добро пожаловать"
        welcomeTextView.textAlignment = .center
        welcomeTextView.textColor = .gray

        authorizeButton.setTitle("Войти через VK", for: .normal)
        authorizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        authorizeButton.setTitleColor(.white, for: .normal)
        authorizeButton.backgroundColor = AppColors().vkColor
        authorizeButton.layer.cornerRadius = 24
        authorizeButton.layer.masksToBounds = true
    }
}
