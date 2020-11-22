

import UIKit

final class EventScreenViewController: UIViewController {

    let imageOfPerson = UIImageView()
    let imageSignOfPeople = UIImageView()
    let nameOfPerson = UILabel()
    let labelTimeTitle = UILabel()
    let labelTime = UILabel()
    let labelDescriptionTitle = UILabel()
    let labelDescription = UILabel()
    let labelPlaceTitle = UILabel()
    let labelPlace = UILabel()
    let ButtonSignUp = UIButton()
    let ButtonPrivateMessage = UIButton()

    let stackViewTopLabel = UIStackView()
    let stackViewTime = UIStackView()
    let stackViewDescription = UIStackView()
    let stackViewPlace = UIStackView()
    let stackViewMembers = UIStackView()
    let stackViewButtons = UIStackView()
    
    
    
    let commonStack = UIStackView()
    let scrollView = UIScrollView()

    
	private let output: EventScreenViewOutput

    init(output: EventScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor.systemBackground
        
        imageSignOfPeople.image = UIImage(systemName: "person.3")
        stackViewMembers.addArrangedSubview(imageSignOfPeople)
        
        
        output.getData()    //обращение к Presenter, для получение данных о пользователе
        output.checkMembership()

    
        labelTimeTitle.text = "Дата"
        labelDescriptionTitle.text = "Описание"
        labelPlaceTitle.text = "Место"
        
        
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(commonStack)
        
        commonStack.addArrangedSubview(stackViewTopLabel)
        commonStack.addArrangedSubview(stackViewTime)
        commonStack.addArrangedSubview(stackViewDescription)
        commonStack.addArrangedSubview(stackViewPlace)
        commonStack.addArrangedSubview(stackViewMembers)
        commonStack.addArrangedSubview(stackViewButtons)

        commonStack.spacing = 30
        


        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageOfPerson.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageOfPerson.layer.cornerRadius = 10
        imageOfPerson.clipsToBounds = true
        
        
        nameOfPerson.textColor = .white
        nameOfPerson.font = nameOfPerson.font.withSize(20)

        labelTime.font = labelTime.font.withSize(20)


        [labelPlace, labelDescription, labelTime
        ].forEach({
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
            $0.font = labelPlace.font.withSize(20)
        })
        
        ButtonPrivateMessage.setTitle("VK", for: .normal)
        ButtonPrivateMessage.addTarget(self, action:#selector(self.pressedButtonPrivateMessage), for: .touchUpInside) //привязали к кнопке функцию, которая будет выполняться, при ее нажатии
        ButtonSignUp.addTarget(self, action:#selector(self.pressedButtonSignUp), for: .touchUpInside) //привязали к кнопке функцию, которая будет выполняться, при ее нажатии

        
        
        ButtonPrivateMessage.setTitleColor(.secondarySystemBackground, for: .normal)
        ButtonPrivateMessage.titleLabel?.font = .systemFont(ofSize: 20)
        ButtonPrivateMessage.setTitleColor(UIColor.white, for: .normal)
        ButtonSignUp.layer.cornerRadius = 10
        ButtonPrivateMessage.layer.cornerRadius = 10
        ButtonPrivateMessage.backgroundColor = .systemBlue

        ButtonPrivateMessage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        

        
        stackViewTopLabel.axis = .horizontal
        stackViewTopLabel.distribution = .fillProportionally

        stackViewTopLabel.backgroundColor = .systemBlue
        stackViewTopLabel.layer.cornerRadius = 10
        stackViewTopLabel.spacing = 20
        
        stackViewTopLabel.addArrangedSubview(imageOfPerson)
        stackViewTopLabel.addArrangedSubview(nameOfPerson)
        
        stackViewMembers.axis = .horizontal
        stackViewMembers.distribution = .fill
        stackViewMembers.spacing = 6
        
        imageSignOfPeople.contentMode = .scaleAspectFit
        imageSignOfPeople.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageSignOfPeople.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
    
        stackViewMembers.addArrangedSubview(UIImageView())
        
        
        let organizerScreen = UITapGestureRecognizer(target: self, action:#selector(self.pressedOrganizerScreen)) //добавление действие на stackview
        stackViewTopLabel.addGestureRecognizer(organizerScreen)
    
        
        [commonStack,
         stackViewTime,
         stackViewDescription,
         stackViewPlace
        ].forEach({
            $0.axis = .vertical
            $0.distribution = .fill
        });
        
        stackViewButtons.axis = .horizontal
        stackViewButtons.distribution = .fill
        stackViewButtons.spacing = 15
        

        stackViewTime.addArrangedSubview(labelTimeTitle)
        stackViewTime.addArrangedSubview(labelTime)
        
        stackViewDescription.addArrangedSubview(labelDescriptionTitle)
        stackViewDescription.addArrangedSubview(labelDescription)

        stackViewPlace.addArrangedSubview(labelPlaceTitle)
        stackViewPlace.addArrangedSubview(labelPlace)
        
        stackViewButtons.addArrangedSubview(ButtonSignUp)
        stackViewButtons.addArrangedSubview(ButtonPrivateMessage)

        self.setupConstraints()
    }

	override func viewDidLoad() {
		super.viewDidLoad()

        self.navigationItem.title = "Мероприятие"
	}
    
    @IBAction func pressedOrganizerScreen(_ sender: UIButton) {
        output.goToOrganizerScreen()
    }
    
    
    @IBAction func pressedButtonSignUp(_ sender: UIButton) {
        if self.ButtonSignUp.titleLabel?.text != "Вы подали заявку"{
            output.singUpForEvent()
            loadView()
        }
    }
    
    @IBAction func pressedButtonPrivateMessage(_ sender: UIButton) {
        print("ButtonPrivateMessage")
    }
    
    func setupConstraints() {
        self.stackViewTopLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewDescription.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewTime.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewPlace.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewMembers.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.commonStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        [
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            commonStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            commonStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            commonStack.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 10),
            commonStack.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -10),

            stackViewTopLabel.heightAnchor.constraint(equalToConstant: 50),
            stackViewTopLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 10),
            stackViewTopLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -10),
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50)
        ].forEach({
            $0.isActive = true
        })
    }
}

extension EventScreenViewController: EventScreenViewInput {
    func setButtonOn() {
        ButtonSignUp.backgroundColor = UIColor.systemBlue
        ButtonSignUp.setTitleColor(UIColor.white, for: .normal)
        ButtonSignUp.setTitle("Хочу пойти", for: .normal)
    }
    
    func setButtonOff() {
        ButtonSignUp.backgroundColor = UIColor.systemGray
        ButtonSignUp.setTitleColor(UIColor.white, for: .normal)
        ButtonSignUp.setTitle("Вы подали заявку", for: .normal)
    }
    
    func setEventAndOrganizerData(_ person: Profile, _ event: Event){
        nameOfPerson.text = "\(person.name) \(person.surname)"
        imageOfPerson.image = UIImage(named: person.avatarUrl!)
        labelTime.text = event.date.dayMonthYearFormat()
        labelPlace.text = event.place
        labelDescription.text = event.description
        

        for i in 0..<event.idMembers.count {
            let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == event.idMembers[i] })!
            let imageUrl = Common.profiles.profiles[indexPerson].avatarUrl
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageUrl ?? "person.circle")
            imageView.contentMode = .scaleAspectFill
            imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            stackViewMembers.addArrangedSubview(imageView)
        }
    }
    

}

