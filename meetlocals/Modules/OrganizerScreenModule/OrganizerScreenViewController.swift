import UIKit

final class OrganizerScreenViewController: UIViewController {
    
    let imageOfPerson = UIImageView()
    let nameOfPerson = UILabel()
    
    let stackViewTopLabel = UIStackView()
    
    let scrollView = UIScrollView()

    
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
        self.view.backgroundColor = UIColor.systemBackground
        output.getData()
        
        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        scrollView.addSubview(stackViewTopLabel)
        
        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageOfPerson.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageOfPerson.layer.cornerRadius = imageOfPerson.frame.height/2
        imageOfPerson.layer.cornerRadius = 50
        imageOfPerson.clipsToBounds = true
        
        
        nameOfPerson.font = nameOfPerson.font.withSize(25)
        
        
        stackViewTopLabel.axis = .horizontal
        stackViewTopLabel.distribution = .fillProportionally

        stackViewTopLabel.layer.cornerRadius = 10
        stackViewTopLabel.spacing = 20
        
        stackViewTopLabel.addArrangedSubview(imageOfPerson)
        stackViewTopLabel.addArrangedSubview(nameOfPerson)
        
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
        self.stackViewTopLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false

        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),

            stackViewTopLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackViewTopLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            stackViewTopLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 10),
            stackViewTopLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -10),
        ].forEach({
            $0.isActive = true
        })
    }
}


extension OrganizerScreenViewController: OrganizerScreenViewInput {
    func setOrganizerData(person: Profile) {
        nameOfPerson.text = "\(person.name) \(person.surname)"
        imageOfPerson.image =  UIImage(named: person.avatarUrl!)
    }
}
