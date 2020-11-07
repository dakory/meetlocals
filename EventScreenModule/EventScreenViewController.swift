

import UIKit

final class EventScreenViewController: UIViewController {

    let imageOfPerson = UIImageView()
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
        self.view.backgroundColor = .secondarySystemBackground
        output.getData()    //обращение к Presenter, для получение данных о пользователе
        
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
        commonStack.addArrangedSubview(stackViewButtons)

        commonStack.spacing = 30
        
            
        
    //    imageOfPerson.image = UIImage(named: "exampleImageOfPerson") //должны достать из БД
        imageOfPerson.contentMode = .scaleAspectFit
        imageOfPerson.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageOfPerson.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imageOfPerson.layer.cornerRadius = 10
        imageOfPerson.clipsToBounds = true
        
        
        
    //    nameOfPerson.text = "Иванов Иван" //должны достать из БД
        nameOfPerson.textColor = .white
        nameOfPerson.font = nameOfPerson.font.withSize(20)

    //    labelTime.text = "25.04.2020"  //должны достать из БД
        labelTime.font = labelTime.font.withSize(20)

   //     labelPlace.text = "Москва, Подкопаевский переулок, 5"  //должны достать из БД
   //     labelDescription.text = "Ищу компанию для похода на фестиваль из 4 человек. Хочу пообщаться и найти новых друзей"      //должны достать из БД

        [labelPlace, labelDescription, labelTime
        ].forEach({
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
            $0.font = labelPlace.font.withSize(20)
        })
        
        ButtonSignUp.setTitle("Хочу пойти", for: .normal)
        ButtonPrivateMessage.setTitle("VK", for: .normal)
        ButtonSignUp.addTarget(self, action:#selector(self.pressedButtonSignUp), for: .touchUpInside) //привязали к кнопке функцию, которая будет выполняться, при ее нажатии
        ButtonPrivateMessage.addTarget(self, action:#selector(self.pressedButtonPrivateMessage), for: .touchUpInside) //привязали к кнопке функцию, которая будет выполняться, при ее нажатии

        
        [ButtonSignUp,
         ButtonPrivateMessage
        ].forEach({
            $0.setTitleColor(.secondarySystemBackground, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 20)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .systemBlue
        });
        ButtonPrivateMessage.widthAnchor.constraint(equalToConstant: 70).isActive = true

        
        stackViewTopLabel.axis = .horizontal
        stackViewTopLabel.distribution = .fillProportionally

        stackViewTopLabel.backgroundColor = .systemBlue
        stackViewTopLabel.layer.cornerRadius = 10
        stackViewTopLabel.spacing = 20
        
        stackViewTopLabel.addArrangedSubview(imageOfPerson)
        stackViewTopLabel.addArrangedSubview(nameOfPerson)
        
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
        sender.isSelected = !sender.isSelected
              if sender.isSelected{
                sender.backgroundColor = UIColor.systemGray
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.setTitle("Вы подали заявку", for: .normal)
                 }
              else{
                sender.backgroundColor = UIColor.systemBlue
                sender.setTitleColor(UIColor.white, for: .normal)
                sender.setTitle("Хочу пойти", for: .normal)

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
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50),
        ].forEach({
            $0.isActive = true
        })
    }
}

extension EventScreenViewController: EventScreenViewInput {

}

