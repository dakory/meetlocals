

import UIKit

final class EventScreenViewController: UIViewController {

    let nameEvent = UILabel()
    let imageOfPerson = UIImageView()
    let imageSignOfPeople = UIImageView()
    let nameOfPerson = UILabel()
    let nameOfPersonTitle = UILabel()
    let labelTimeTitle = UILabel()
    let labelTime = UILabel()
    let labelDescriptionTitle = UILabel()
    let labelDescription = UILabel()
    let labelPlaceTitle = UILabel()
    let labelPlace = UILabel()
    let buttonPrivateMessage = UIButton()
    let viewButtonPrivateMessage = UIView()

    let stackLabelTimeTitle = UIStackView()
    let stackLabelPlaceTitle = UIStackView()
    let stackLabelDescriptionTitle = UIStackView()
    let imageLabelTimeTitle = UIImageView()
    let imageLabelPlaceTitle = UIImageView()
    let imageLabelDescriptionTitle = UIImageView()

    let stackViewTopLabel = UIStackView()
    let stackTopLabelNames = UIStackView()
    let stackViewTime = UIStackView()
    let stackViewDescription = UIStackView()
    let stackViewPlace = UIStackView()
    let stackViewMembers = UIStackView()
    let buttonSignUp = UIButton()
    let viewButtonSignUp = UIView()
    
    let viewStackTopLabelNames = UIView()
    
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
        
        output.checkMembership()
        output.getData()    //обращение к Presenter, для получение данных о пользователе

        nameOfPersonTitle.text = "Организатор"
        labelTimeTitle.text = "Дата и время"
        labelDescriptionTitle.text = "Описание"
        labelPlaceTitle.text = "Местоположение"
        
        imageLabelTimeTitle.image = UIImage(systemName: "calendar")
        imageLabelPlaceTitle.image = UIImage(systemName: "location.fill")
        imageLabelDescriptionTitle.image = UIImage(systemName: "doc.plaintext")
        
        [imageLabelTimeTitle, imageLabelPlaceTitle, imageLabelDescriptionTitle
        ].forEach({
            $0.contentMode = .scaleAspectFit
            $0.widthAnchor.constraint(equalToConstant: 22).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        })
        
        [nameOfPersonTitle, labelTimeTitle, labelDescriptionTitle, labelPlaceTitle
        ].forEach({
            $0.font = $0.font.withSize(14)
            $0.textColor = .darkGray
        })
        
        [labelPlace, labelDescription, labelTime, nameOfPerson
        ].forEach({
            $0.font = $0.font.withSize(16)
        })
        
        [nameOfPersonTitle, labelTimeTitle, labelDescriptionTitle, labelPlaceTitle, nameEvent, labelPlace, labelDescription, labelTime, nameOfPersonTitle, nameOfPerson
        ].forEach({
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        })
        
        stackLabelTimeTitle.addArrangedSubview(imageLabelTimeTitle)
        stackLabelPlaceTitle.addArrangedSubview(imageLabelPlaceTitle)
        stackLabelDescriptionTitle.addArrangedSubview(imageLabelDescriptionTitle)
        stackLabelTimeTitle.addArrangedSubview(labelTimeTitle)
        stackLabelPlaceTitle.addArrangedSubview(labelPlaceTitle)
        stackLabelDescriptionTitle.addArrangedSubview(labelDescriptionTitle)

        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(commonStack)
        
        [stackLabelTimeTitle, stackLabelPlaceTitle,stackLabelDescriptionTitle
        ].forEach({
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 8
        });

        [stackViewTime, stackViewDescription, stackViewPlace
        ].forEach({
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 8
        });
        
        [stackViewTopLabel, stackViewMembers
        ].forEach({
            $0.axis = .horizontal
            $0.distribution = .fill
        });
        
        stackTopLabelNames.axis = .vertical
        stackTopLabelNames.distribution = .fillEqually
        
        stackViewMembers.spacing = 6
        
        commonStack.axis = .vertical
        commonStack.distribution = .fill
        
        commonStack.addArrangedSubview(nameEvent)
        commonStack.addArrangedSubview(stackViewTopLabel)
        commonStack.addArrangedSubview(stackViewTime)
        commonStack.addArrangedSubview(stackViewPlace)
        commonStack.addArrangedSubview(stackViewDescription)
        commonStack.addArrangedSubview(stackViewMembers)
        commonStack.addArrangedSubview(viewButtonSignUp)

        commonStack.spacing = 30
        
        buttonSignUp.layer.cornerRadius = 25
        
        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.layer.cornerRadius = 30
        imageOfPerson.clipsToBounds = true
        
        imageSignOfPeople.contentMode = .scaleAspectFit

        nameEvent.font = nameEvent.font.withSize(22)
        nameOfPerson.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        buttonPrivateMessage.setImage(UIImage(named: "vk"), for: .normal)
//        ButtonPrivateMessage.titleLabel?.font = UIFont(name: "FontAwesome5Brands-Regular", size: 20) //не получает нужный шрифт
//        ButtonPrivateMessage.setTitleColor(.systemBlue, for: .normal)
//        ButtonPrivateMessage.layer.cornerRadius = 20
//        ButtonPrivateMessage.layer.borderColor = UIColor.systemBlue.cgColor
//        ButtonPrivateMessage.layer.borderWidth = 2

        stackTopLabelNames.addArrangedSubview(nameOfPerson)
        stackTopLabelNames.addArrangedSubview(nameOfPersonTitle)
        
        viewButtonSignUp.addSubview(buttonSignUp)
        viewStackTopLabelNames.addSubview(stackTopLabelNames)

        
        stackViewTopLabel.addArrangedSubview(imageOfPerson)
        stackViewTopLabel.addArrangedSubview(viewStackTopLabelNames)
        stackViewTopLabel.addArrangedSubview(viewButtonPrivateMessage)
        
        viewButtonPrivateMessage.addSubview(buttonPrivateMessage)
    
        stackViewMembers.addArrangedSubview(UIImageView())
        

        stackViewTime.addArrangedSubview(stackLabelTimeTitle)
        stackViewTime.addArrangedSubview(labelTime)
        
        stackViewDescription.addArrangedSubview(stackLabelDescriptionTitle)
        stackViewDescription.addArrangedSubview(labelDescription)

        stackViewPlace.addArrangedSubview(stackLabelPlaceTitle)
        stackViewPlace.addArrangedSubview(labelPlace)
        

        buttonPrivateMessage.addTarget(self, action:#selector(self.pressedButtonPrivateMessage), for: .touchUpInside)

        buttonSignUp.addTarget(self, action:#selector(self.pressedButtonSignUp), for: .touchUpInside)
  
        stackViewTopLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.pressedOrganizerScreen)))

        self.setupConstraints()
    }


	override func viewDidLoad() {
		super.viewDidLoad()

      //  self.navigationItem.title = "Мероприятие"
	}
    
    @IBAction func pressedOrganizerScreen(_ sender: UIButton) {
        output.goToOrganizerScreen()
    }
    
    
    @IBAction func pressedButtonSignUp(_ sender: UIButton) {
        output.singUpForEvent()
        output.checkMembership()
        // loadView()
        stackViewMembers.subviews.forEach({ (view) in
            view.removeFromSuperview()
        })
        stackViewMembers.addArrangedSubview(imageSignOfPeople)
        output.getData()
        stackViewMembers.addArrangedSubview(UIImageView())
        self.setupConstraints()
        
    }
    
    @IBAction func pressedButtonPrivateMessage(_ sender: UIButton) {
        output.goToVkPresenter()
    }
    
    func setupConstraints() {
        self.stackViewTopLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackTopLabelNames.translatesAutoresizingMaskIntoConstraints = false
        self.viewStackTopLabelNames.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.commonStack.translatesAutoresizingMaskIntoConstraints = false
        self.imageSignOfPeople.translatesAutoresizingMaskIntoConstraints = false
        

        self.buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.viewButtonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.viewButtonPrivateMessage.translatesAutoresizingMaskIntoConstraints = false
        self.buttonPrivateMessage.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            commonStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackViewTopLabel.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor, constant: 10),
            stackViewTopLabel.trailingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.trailingAnchor, constant: -10),
            commonStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            
            
            imageOfPerson.widthAnchor.constraint(equalToConstant: 60),
            
            stackTopLabelNames.centerYAnchor.constraint(equalTo: viewStackTopLabelNames.centerYAnchor),
            stackTopLabelNames.leadingAnchor.constraint(equalTo: viewStackTopLabelNames.leadingAnchor, constant: 8),

            buttonPrivateMessage.heightAnchor.constraint(equalToConstant: 60),
            buttonPrivateMessage.widthAnchor.constraint(equalToConstant: 60),
            buttonPrivateMessage.centerYAnchor.constraint(equalTo: viewButtonPrivateMessage.centerYAnchor),
            buttonPrivateMessage.centerXAnchor.constraint(equalTo: viewButtonPrivateMessage.centerXAnchor),
            viewButtonPrivateMessage.widthAnchor.constraint(equalToConstant: 80),

            stackViewTopLabel.heightAnchor.constraint(equalToConstant: 60),
            viewButtonPrivateMessage.leadingAnchor.constraint(equalTo: viewStackTopLabelNames.trailingAnchor),
            viewStackTopLabelNames.leadingAnchor.constraint(equalTo: imageOfPerson.trailingAnchor),


            imageSignOfPeople.widthAnchor.constraint(equalToConstant: 40),
            imageSignOfPeople.heightAnchor.constraint(equalToConstant: 40),
            
            viewButtonSignUp.heightAnchor.constraint(equalToConstant: 50),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 50),
            buttonSignUp.centerXAnchor.constraint(equalTo: viewButtonSignUp.centerXAnchor),
            buttonSignUp.centerYAnchor.constraint(equalTo: viewButtonSignUp.centerYAnchor),
            buttonSignUp.leadingAnchor.constraint(equalTo: viewButtonSignUp.leadingAnchor, constant: 30),
            buttonSignUp.leadingAnchor.constraint(equalTo: viewButtonSignUp.leadingAnchor, constant: 30)
        ].forEach({
            $0.isActive = true
        })
    }
}

extension EventScreenViewController: EventScreenViewInput {
    func setButton(_ check: Bool) {
        buttonSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        if !check {
            buttonSignUp.setTitle("Участвовать", for: .normal)
            buttonSignUp.backgroundColor = UIColor.systemBlue
        }
        else {
            buttonSignUp.setTitle("Отменить заявку", for: .normal)
            buttonSignUp.backgroundColor = UIColor.systemRed
        }
    }

    
    func setEventAndOrganizerData(_ person: Profile, _ event: Event){
        nameOfPerson.text = "\(person.name)"
        nameEvent.text = event.name
        imageOfPerson.image = UIImage(named: person.avatarUrl!)
        labelTime.text = event.date.dayMonthYearFormat()
        labelPlace.text = event.place
        labelDescription.text = event.description
        
        imageSignOfPeople.image = UIImage(systemName: "person.3")
        stackViewMembers.addArrangedSubview(imageSignOfPeople)

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


