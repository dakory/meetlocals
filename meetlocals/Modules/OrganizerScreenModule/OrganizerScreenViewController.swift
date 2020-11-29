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
        self.view.backgroundColor = #colorLiteral(red: 0.9567590356, green: 0.9569227099, blue: 0.9567485452, alpha: 1)
        output.getData()
        
        scrollView.alwaysBounceVertical = true

        view.addSubview(scrollView)
        scrollView.addSubview(imageOfPerson)
        scrollView.addSubview(nameOfPerson)
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
        nameOfPerson.numberOfLines = 1
        nameOfPerson.textAlignment = .center
        nameOfPerson.backgroundColor = .black
            
        imageOfPerson.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 229).isActive = true
        imageOfPerson.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -60).isActive = true
        imageOfPerson.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 60).isActive = true
        imageOfPerson.bottomAnchor.constraint(equalTo: imageOfPerson.topAnchor, constant: 120).isActive = true
        
        nameOfPerson.topAnchor.constraint(equalTo: imageOfPerson.bottomAnchor, constant: 26).isActive = true
    }
}


extension OrganizerScreenViewController: OrganizerScreenViewInput {
    func setOrganizerData(person: Profile) {
        nameOfPerson.text = "\(person.name) \(person.surname)"
        imageOfPerson.image =  UIImage(named: person.avatarUrl!)
    }
}
