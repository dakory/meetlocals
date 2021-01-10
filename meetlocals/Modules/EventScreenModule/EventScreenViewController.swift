

import UIKit

final class EventScreenViewController: UIViewController {

    private let commonStack = UIStackView()
    private let scrollView = UIScrollView()
    
    private let nameEvent = UILabel()
    
    private let imageOfPerson = UIImageView()
    private let nameOfPerson = UILabel()
    private let nameOfPersonTitle = UILabel()
    private let buttonPrivateMessage = UIButton()
    private let viewButtonPrivateMessage = UIView()
    
    private let stackViewTime = UIStackView()
    private let stackLabelTimeTitle = UIStackView()
    private let viewStackTopLabelNames = UIView()
    private let labelTimeTitle = UILabel()
    private let labelTime = UILabel()
    private let imageLabelTimeTitle = UIImageView()
    private let stackViewTopLabel = UIStackView()
    private let stackTopLabelNames = UIStackView()

    private let stackViewDescription = UIStackView()
    private let stackLabelDescriptionTitle = UIStackView()
    private let labelDescriptionTitle = UILabel()
    private let labelDescription = UILabel()
    private let imageLabelDescriptionTitle = UIImageView()

    private let stackViewPlace = UIStackView()
    private let stackLabelPlaceTitle = UIStackView()
    private let labelPlaceTitle = UILabel()
    private let labelPlace = UILabel()
    private let imageLabelPlaceTitle = UIImageView()

    private let stackViewMembers = UIStackView()
    private let stackTitleMembers = UIStackView()
    private let labelMembersTitle = UILabel()
    private let imageMembers = UIImageView()
    private let stackListMembers = UIStackView()
    private let scrollViewFriends = UIScrollView()
    private let viewForScrollViewFriends = UIView()

    
    private let viewButtonSignUp = UIView()
    private let buttonSignUp = UIButton()

    private let output: EventScreenViewOutput
    
    var meetingId: Int?
    var organizerId: Int?

    init(output: EventScreenViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.backgroundColor = UIColor(rgb: 0xFAFAFA)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        output.checkMembershipPresenter()
        
        
        scrollView.alwaysBounceVertical = true
        scrollViewFriends.alwaysBounceHorizontal = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(commonStack)

        nameOfPersonTitle.text = "Организатор"
        labelTimeTitle.text = "Дата и время"
        labelDescriptionTitle.text = "Описание"
        labelPlaceTitle.text = "Местоположение"
        
        imageLabelTimeTitle.image = UIImage(systemName: "calendar")
        imageLabelPlaceTitle.image = UIImage(systemName: "location.fill")
        imageLabelDescriptionTitle.image = UIImage(systemName: "doc.plaintext")
        imageMembers.image = UIImage(systemName: "person.crop.circle.badge.checkmark")
        
        [imageLabelTimeTitle, imageLabelPlaceTitle, imageLabelDescriptionTitle, imageMembers
        ].forEach({
            $0.contentMode = .scaleAspectFit
            $0.widthAnchor.constraint(equalToConstant: 22).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 22).isActive = true
        })
        
        [nameOfPersonTitle, labelTimeTitle, labelDescriptionTitle, labelPlaceTitle, labelMembersTitle
        ].forEach({
            $0.font = $0.font.withSize(15)
            $0.textColor = .darkGray
        })
        
        [labelPlace, labelDescription, labelTime, nameOfPerson,
        ].forEach({
            $0.font = $0.font.withSize(18)
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
        stackTitleMembers.addArrangedSubview(imageMembers)
        stackLabelDescriptionTitle.addArrangedSubview(labelDescriptionTitle)

        
        viewForScrollViewFriends.addSubview(scrollViewFriends)
        
        
        [stackLabelTimeTitle, stackLabelPlaceTitle,stackLabelDescriptionTitle, stackTitleMembers, stackViewTopLabel, stackListMembers
        ].forEach({
            $0.axis = .horizontal
            $0.distribution = .fill
        });
        
        [stackViewTime, stackViewDescription, stackViewPlace, stackViewMembers, stackTopLabelNames, commonStack
        ].forEach({
            $0.axis = .vertical
            $0.distribution = .fill
        });
        
        [stackLabelTimeTitle, stackLabelPlaceTitle,stackLabelDescriptionTitle, stackTitleMembers, stackViewTime, stackViewDescription, stackViewPlace, stackViewMembers
        ].forEach({
            $0.spacing = 8
        });

        stackTopLabelNames.distribution = .equalSpacing


        [nameEvent, stackViewTopLabel, stackViewTime, stackViewPlace, stackViewDescription, stackViewMembers, viewButtonSignUp
        ].forEach({
            commonStack.addArrangedSubview($0)
        });

        commonStack.spacing = 30
        stackListMembers.spacing = 14

        
        buttonSignUp.layer.cornerRadius = 24

//        buttonSignUp.layer.borderWidth
        
        imageOfPerson.contentMode = .scaleAspectFill
        imageOfPerson.layer.cornerRadius = 30
        imageOfPerson.clipsToBounds = true
        

        nameEvent.font = UIFont.systemFont(ofSize: 22, weight: .light)
        nameOfPerson.font = UIFont.systemFont(ofSize: 18, weight: .medium)

        buttonPrivateMessage.setImage(UIImage(named: "vk_icon_blue"), for: .normal)
        buttonPrivateMessage.layer.borderWidth = 2
        buttonPrivateMessage.layer.borderColor = UIColor(rgb: 0x396AE9).cgColor
        buttonPrivateMessage.layer.cornerRadius = 20

        stackTopLabelNames.addArrangedSubview(nameOfPerson)
        stackTopLabelNames.addArrangedSubview(nameOfPersonTitle)
        
        viewButtonSignUp.addSubview(buttonSignUp)
        viewStackTopLabelNames.addSubview(stackTopLabelNames)

        
        stackViewTopLabel.addArrangedSubview(imageOfPerson)
        stackViewTopLabel.addArrangedSubview(viewStackTopLabelNames)
        stackViewTopLabel.addArrangedSubview(viewButtonPrivateMessage)
        
        viewButtonPrivateMessage.addSubview(buttonPrivateMessage)
    
        stackListMembers.addArrangedSubview(UIImageView())

        stackViewTime.addArrangedSubview(stackLabelTimeTitle)
        stackViewTime.addArrangedSubview(labelTime)
        
        stackViewDescription.addArrangedSubview(stackLabelDescriptionTitle)
        stackViewDescription.addArrangedSubview(labelDescription)

        stackViewPlace.addArrangedSubview(stackLabelPlaceTitle)
        stackViewPlace.addArrangedSubview(labelPlace)
        
        stackTitleMembers.addArrangedSubview(labelMembersTitle)
        
        stackViewMembers.addArrangedSubview(stackTitleMembers)
        stackViewMembers.addArrangedSubview(viewForScrollViewFriends)
        scrollViewFriends.addSubview(stackListMembers)

        
        buttonPrivateMessage.addTarget(self, action:#selector(self.pressedButtonPrivateMessage), for: .touchUpInside)
        buttonSignUp.addTarget(self, action:#selector(self.pressedButtonSignUp), for: .touchUpInside)
        stackViewTopLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.pressedOrganizerScreen)))

        self.setupConstraints()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: #selector(self.back)
        )
        self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "chevron.backward")
    }
    
    @IBAction func pressedOrganizerScreen(_ sender: UIButton) {
        output.goToOrganizerScreen()
    }
    
    
    @IBAction func pressedButtonSignUp(_ sender: UIButton) {
        buttonSignUp.tap()
        if output.checkCurrentUserIsOrganizer()
        {
            output.deleteEvent()
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
        }
        else {
            output.singUpForEvent()
            output.checkMembershipPresenter()
        }
    }

    
    @IBAction func pressedButtonPrivateMessage(_ sender: UIButton) {
        output.goToVkPresenter(toOrganizer: true, id: 0)
    }
    
    @IBAction func pressedMember(_ sender: UIButton) {
        output.goToProfile(id: Int((sender.titleLabel?.text)!))
    }
    
    func setupConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.commonStack.translatesAutoresizingMaskIntoConstraints = false

        self.stackTopLabelNames.translatesAutoresizingMaskIntoConstraints = false
        self.viewStackTopLabelNames.translatesAutoresizingMaskIntoConstraints = false
        
        self.buttonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.viewButtonSignUp.translatesAutoresizingMaskIntoConstraints = false
        self.viewButtonPrivateMessage.translatesAutoresizingMaskIntoConstraints = false
        self.buttonPrivateMessage.translatesAutoresizingMaskIntoConstraints = false
        
        self.scrollViewFriends.translatesAutoresizingMaskIntoConstraints = false
        self.viewForScrollViewFriends.translatesAutoresizingMaskIntoConstraints = false
        self.stackListMembers.translatesAutoresizingMaskIntoConstraints = false

        
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            commonStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30),
            
            commonStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            commonStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            commonStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            commonStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
            

            imageOfPerson.widthAnchor.constraint(equalToConstant: 60),

            stackTopLabelNames.topAnchor.constraint(equalTo: viewStackTopLabelNames.topAnchor),
            stackTopLabelNames.leadingAnchor.constraint(equalTo: viewStackTopLabelNames.leadingAnchor, constant: 8),
            stackViewTopLabel.heightAnchor.constraint(equalToConstant: 60),
            viewStackTopLabelNames.leadingAnchor.constraint(equalTo: imageOfPerson.trailingAnchor),
            
            buttonPrivateMessage.heightAnchor.constraint(equalToConstant: 40),
            buttonPrivateMessage.widthAnchor.constraint(equalToConstant: 80),
            buttonPrivateMessage.bottomAnchor.constraint(equalTo: viewButtonPrivateMessage.bottomAnchor),
            buttonPrivateMessage.trailingAnchor.constraint(equalTo: viewButtonPrivateMessage.trailingAnchor),
            viewButtonPrivateMessage.leadingAnchor.constraint(equalTo: viewStackTopLabelNames.trailingAnchor),
            viewButtonPrivateMessage.widthAnchor.constraint(equalToConstant: 80),

            viewButtonSignUp.heightAnchor.constraint(equalToConstant: 48),
            buttonSignUp.heightAnchor.constraint(equalToConstant: 48),
            buttonSignUp.centerYAnchor.constraint(equalTo: viewButtonSignUp.centerYAnchor),
            buttonSignUp.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37),
            buttonSignUp.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:
            -37),

            viewForScrollViewFriends.heightAnchor.constraint(equalToConstant: 104),
            scrollViewFriends.topAnchor.constraint(equalTo: viewForScrollViewFriends.topAnchor),
            scrollViewFriends.leadingAnchor.constraint(equalTo: viewForScrollViewFriends.leadingAnchor),
            scrollViewFriends.trailingAnchor.constraint(equalTo: viewForScrollViewFriends.trailingAnchor),
            scrollViewFriends.bottomAnchor.constraint(equalTo: viewForScrollViewFriends.bottomAnchor),

            stackListMembers.topAnchor.constraint(equalTo: scrollViewFriends.topAnchor),
            stackListMembers.leadingAnchor.constraint(equalTo: scrollViewFriends.leadingAnchor),
            stackListMembers.trailingAnchor.constraint(equalTo: scrollViewFriends.trailingAnchor),
            stackListMembers.bottomAnchor.constraint(equalTo: scrollViewFriends.bottomAnchor),
        ].forEach({
            $0.isActive = true
        })
    }
}

extension EventScreenViewController: EventScreenViewInput {
    
    
    func reloadMembers(){
        stackListMembers.subviews.forEach({ (view) in
            view.removeFromSuperview()
        })
        output.getData()
        stackListMembers.addArrangedSubview(UIImageView())
    }
    
    
    func setButton(_ check: Bool) {
        buttonSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        if output.checkCurrentUserIsOrganizer() {
            buttonSignUp.setTitle("Удалить событие", for: .normal)
            buttonSignUp.backgroundColor = UIColor(rgb: 0xE939C2)
        }
        else if check {
            buttonSignUp.setTitle("Отменить заявку", for: .normal)
            buttonSignUp.backgroundColor = UIColor(rgb: 0xE939C2)
        }
        else {
            buttonSignUp.setTitle("Участвовать", for: .normal)
            buttonSignUp.backgroundColor = UIColor(rgb: 0x396AE9)
        }
    }

    
    func setEventAndOrganizerData(_ person: Profile, _ event: Event){
        nameOfPerson.text = person.name
        nameEvent.text = event.name

        guard let avatarUrl = person.avatarUrl else {
            print("Error: User has no avatar")
            return
        }
        imageOfPerson.image = UIImage(named: "exampleImageOfPerson")
        if avatarUrl != "exampleImageOfPerson" && avatarUrl != "" {
            imageOfPerson.downloaded(from: avatarUrl)
        }

        labelTime.text = event.date.dayMonthYearFormat()
        labelPlace.text = event.place
        labelDescription.text = event.description
        labelMembersTitle.text = "Участники \(String(event.idMembers.count))"
        
        for i in 0..<event.idMembers.count {
            let viewPerson = UIView()
            let imageView = UIImageView()
            let stackNameSurname = UIStackView()
            let name = UILabel()
            let surname = UILabel()
            let button = UIButton()

            [viewPerson, imageView, stackNameSurname, name, surname, button
                ].forEach({
                    $0.translatesAutoresizingMaskIntoConstraints = false
                })

            let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == event.idMembers[i] })!

            guard let avatarUrl = Common.profiles.profiles[indexPerson].avatarUrl else {
                print("Error: User has no avatar")
                return
            }
            imageView.image = UIImage(named: "exampleImageOfPerson")
            if avatarUrl != "exampleImageOfPerson" && avatarUrl != "" {
                imageView.downloaded(from: avatarUrl)
            }
            
            let fullName = Common.profiles.profiles[indexPerson].name.split(separator: " ")
            name.text = String(fullName[0])
            surname.text = String(fullName[1])
            
            name.font = name.font.withSize(13)
            surname.font = surname.font.withSize(13)

            stackNameSurname.axis = .vertical
            stackNameSurname.distribution = .fill
            stackNameSurname.alignment = .center
            stackNameSurname.spacing = 2
            
            stackNameSurname.addArrangedSubview(name)
            stackNameSurname.addArrangedSubview(surname)

            viewPerson.addSubview(imageView)
            viewPerson.addSubview(stackNameSurname)
            viewPerson.addSubview(button)
            
            viewPerson.heightAnchor.constraint(equalToConstant: 104).isActive = true
            viewPerson.widthAnchor.constraint(equalToConstant: 66).isActive = true
            
            imageView.contentMode = .scaleAspectFill
            imageView.heightAnchor.constraint(equalToConstant: 66).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 66).isActive = true
            imageView.topAnchor.constraint(equalTo: viewPerson.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
            imageView.layer.cornerRadius = 33
            imageView.clipsToBounds = true
            
            stackNameSurname.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
            stackNameSurname.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
            stackNameSurname.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
            stackNameSurname.bottomAnchor.constraint(equalTo: viewPerson.bottomAnchor).isActive = true
            
            name.heightAnchor.constraint(equalToConstant: 13).isActive = true
                        
            button.topAnchor.constraint(equalTo: viewPerson.topAnchor).isActive = true
            button.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: viewPerson.bottomAnchor).isActive = true
            
            button.setTitle(String(Common.profiles.profiles[indexPerson].id), for: .normal)
            button.setTitleColor(.clear, for: .normal)
            button.addTarget(self, action: #selector(self.pressedMember(_:)), for: .touchUpInside)

            stackListMembers.addArrangedSubview(viewPerson)
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



