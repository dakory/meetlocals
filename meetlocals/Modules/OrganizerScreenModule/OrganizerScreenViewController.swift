import UIKit

final class OrganizerScreenViewController: UIViewController {
    
    let imageOfPerson = UIImageView()
    let nameOfPerson = UILabel()
    
    let stackViewTopLabel = UIStackView()
    
    let scrollView = UIScrollView()
    let buttonOpenVK = UIButton()

    
	private let output: OrganizerScreenViewOutput

    init(output: OrganizerScreenViewOutput) {
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
        self.scrollView.addSubview(buttonOpenVK)
        self.setupConstraints()
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(self.back)
        )
	}
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupConstraints() {
        self.imageOfPerson.translatesAutoresizingMaskIntoConstraints = false
        self.nameOfPerson.translatesAutoresizingMaskIntoConstraints = false
        self.buttonOpenVK.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            imageOfPerson.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 229),
            imageOfPerson.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -60),
            imageOfPerson.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 60),
            imageOfPerson.bottomAnchor.constraint(equalTo: imageOfPerson.topAnchor, constant: 120),
        
            nameOfPerson.topAnchor.constraint(equalTo: imageOfPerson.bottomAnchor, constant: 26),
            nameOfPerson.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            nameOfPerson.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            nameOfPerson.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ].forEach({
            $0.isActive = true
        })
        
        
        buttonOpenVK.setTitle("Открыть ВК", for: .normal)
        buttonOpenVK.titleLabel?.font.withSize(17)
        buttonOpenVK.backgroundColor = #colorLiteral(red: 0.9139195085, green: 0.2209282517, blue: 0.7613213658, alpha: 1)
        buttonOpenVK.layer.cornerRadius = 24
        buttonOpenVK.addTarget(self, action: #selector(didTapButtonOpenVK), for: .touchUpInside)
        [
        buttonOpenVK.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        buttonOpenVK.topAnchor.constraint(equalTo: buttonOpenVK.bottomAnchor, constant: -47),
        buttonOpenVK.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
        buttonOpenVK.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
    ].forEach({
                $0.isActive = true
    })
    
        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.layer.cornerRadius = 35
        imageOfPerson.clipsToBounds = true
        
        
        
        nameOfPerson.font = nameOfPerson.font.withSize(16)
        nameOfPerson.numberOfLines = 0
        nameOfPerson.textAlignment = NSTextAlignment.center
    }
    
    @objc
    func didTapButtonOpenVK() {
        buttonOpenVK.tap()
        output.didTapButtonOpenVK()
    }
}


extension OrganizerScreenViewController: OrganizerScreenViewInput {
    func setOrganizerData(person: Profile) {
        nameOfPerson.text = "\(person.name)"
        
        guard let avatarUrl = person.avatarUrl else {
            print("Error: User has no avatar")
            return
        }
        imageOfPerson.image = UIImage(named: "exampleImageOfPerson")
        if avatarUrl != "exampleImageOfPerson" && avatarUrl != "" {
            print("Url: \(avatarUrl)")
            imageOfPerson.downloaded(from: avatarUrl)
        }
    }
    
    @objc func back(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
