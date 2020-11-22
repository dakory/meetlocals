//
//  AddEventController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit
import UITextView_Placeholder

final class AddEventViewController: UIViewController, UITextViewDelegate {
    private let output: AddEventViewOutput
    private let wantLabel = UILabel()
    private let textEventName = UITextView()
    private let textEventDescription = UITextView()
    private let textDate = UIDatePicker()
    private let dateLabel = UILabel()
    private let placeLabel = UILabel()
    private let placeText = UITextView()
    private let buttonAddEvent = UIButton()
    var offsetBeforeShowKeyboard: CGPoint?

    init(output: AddEventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        addAll(view)
        self.view = view
        setupAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem =
           UITabBarItem(
            title: "Новое событие",
            image: UIImage(systemName: "plus"),
            tag: 2)
        self.navigationItem.title = "Новое событие"
        
        
    }
}


extension AddEventViewController: AddEventViewInput {
    func cleanScreen() { //эту функция очищения полей, вызываем после добавления мероприятия
        textEventName.text = ""
        textEventDescription.text = ""
        placeText.text = ""
    }
}



private extension AddEventViewController {
    func addAll(_ view: UIView) {
        view.addSubview(wantLabel)
        view.addSubview(textEventName)
        view.addSubview(textEventDescription)
        view.addSubview(textDate)
        view.addSubview(dateLabel)
        view.addSubview(placeText)
        view.addSubview(placeLabel)
        view.addSubview(buttonAddEvent)
    }
    func setupAll() {
        setupTextEventName()
        setupwandLabel()
        setupTextEventDescription()
        setupDateLabel()
        setupDateText()
        setupPlaceLabel()
        setupPlaceText()
        setupButtonAddEvent()
        
    }
    func setupwandLabel() {
        self.wantLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.wantLabel.bottomAnchor.constraint(equalTo: self.wantLabel.topAnchor, constant: 30).isActive = true
        self.wantLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        self.wantLabel.trailingAnchor.constraint(equalTo: self.wantLabel.leadingAnchor, constant: 55).isActive = true
        self.wantLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.wantLabel.text = "Я хочу"
    }
    
    func setupTextEventName() {
        self.textEventName.topAnchor.constraint(equalTo: self.wantLabel.topAnchor, constant: 0).isActive = true
        self.textEventName.bottomAnchor.constraint(equalTo: self.wantLabel.bottomAnchor, constant: 30).isActive = true
        self.textEventName.leadingAnchor.constraint(equalTo: self.wantLabel.trailingAnchor, constant: 15).isActive = true
        self.textEventName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
        self.textEventName.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.textEventName.backgroundColor = #colorLiteral(red: 0.9021419287, green: 0.9022932649, blue: 0.9021219611, alpha: 1)
        self.textEventName.font = .systemFont(ofSize: 20)
        self.textEventName.placeholder = "Опишите кратко"
        self.textEventName.delegate = self
        self.textEventName.layer.cornerRadius = 10.0
    }
    
    func setupTextEventDescription() {
        self.textEventDescription.topAnchor.constraint(equalTo: self.textEventName.bottomAnchor, constant: 40).isActive = true
        self.textEventDescription.bottomAnchor.constraint(equalTo: self.textEventDescription.topAnchor, constant: 200).isActive = true
        self.textEventDescription.leadingAnchor.constraint(equalTo: self.wantLabel.leadingAnchor, constant: 0).isActive = true
        self.textEventDescription.trailingAnchor.constraint(equalTo: self.textEventName.trailingAnchor, constant: 0).isActive = true
        self.textEventDescription.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.textEventDescription.backgroundColor = #colorLiteral(red: 0.9017923474, green: 0.9021018744, blue: 0.89753896, alpha: 1)
        self.textEventDescription.delegate = self
        self.textEventDescription.font = .systemFont(ofSize: 20)
        self.textEventDescription.placeholder = "А здесь подробнее"
        self.textEventDescription.becomeFirstResponder()
        self.textEventDescription.layer.cornerRadius = 10.0
    }
    
    func setupDateText() {
        self.textDate.topAnchor.constraint(equalTo: self.textEventDescription.bottomAnchor, constant: 15).isActive = true
        self.textDate.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: 30).isActive = true
        self.textDate.trailingAnchor.constraint(equalTo: self.textEventName.trailingAnchor, constant: 0).isActive = true
        self.textDate.leadingAnchor.constraint(equalTo: self.textEventName.leadingAnchor, constant: 0).isActive = true
        self.textDate.translatesAutoresizingMaskIntoConstraints = false
        
        self.textDate.minimumDate = { () -> Date in
            let calendar = Calendar(identifier: .gregorian)
            var components = DateComponents()
            components.hour = 1
            let minDate = calendar.date(byAdding: components, to: Date())
            return minDate!
        }()
        self.textDate.backgroundColor = #colorLiteral(red: 0.9017923474, green: 0.9021018744, blue: 0.89753896, alpha: 1)
    }
    
    func setupDateLabel() {
        self.dateLabel.topAnchor.constraint(equalTo: self.textDate.topAnchor, constant: 0).isActive = true
        self.dateLabel.bottomAnchor.constraint(equalTo: self.textDate.bottomAnchor, constant: 0).isActive = true
        self.dateLabel.leadingAnchor.constraint(equalTo: self.wantLabel.leadingAnchor, constant: 0).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.wantLabel.trailingAnchor, constant: 0).isActive = true
        self.dateLabel.text = "Когда?"
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPlaceLabel() {
        self.placeLabel.topAnchor.constraint(equalTo: self.textDate.bottomAnchor, constant: 15).isActive = true
        self.placeLabel.bottomAnchor.constraint(equalTo: self.placeLabel.topAnchor, constant: 30).isActive = true
        self.placeLabel.leadingAnchor.constraint(equalTo: self.wantLabel.leadingAnchor, constant: 0).isActive = true
        self.placeLabel.trailingAnchor.constraint(equalTo: self.wantLabel.trailingAnchor, constant: 0).isActive = true
        self.placeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeLabel.text = "Где?"
        self.placeText.placeholder = "Место"
    }
    
    func setupPlaceText() {
        self.placeText.topAnchor.constraint(equalTo: self.placeLabel.topAnchor, constant: 0).isActive = true
        self.placeText.bottomAnchor.constraint(equalTo: self.placeText.topAnchor, constant: 75).isActive = true
        self.placeText.trailingAnchor.constraint(equalTo: self.textEventName.trailingAnchor, constant: 0).isActive = true
        self.placeText.leadingAnchor.constraint(equalTo: self.textEventName.leadingAnchor, constant: 0).isActive = true
        
        
        self.placeText.translatesAutoresizingMaskIntoConstraints = false
        self.placeText.delegate = self
        self.placeText.font = .systemFont(ofSize: 20)
        self.placeText.layer.cornerRadius = 10.0
        self.placeText.becomeFirstResponder()
        self.placeText.backgroundColor = #colorLiteral(red: 0.9017923474, green: 0.9021018744, blue: 0.89753896, alpha: 1)
        
    }
    func setupButtonAddEvent() {
        self.buttonAddEvent.translatesAutoresizingMaskIntoConstraints = false
        self.buttonAddEvent.backgroundColor = .blue
        self.buttonAddEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        self.buttonAddEvent.bottomAnchor.constraint(equalTo: self.buttonAddEvent.topAnchor, constant: 45).isActive = true
        self.buttonAddEvent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        self.buttonAddEvent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -35).isActive = true
        self.buttonAddEvent.addTarget(self, action: #selector(didTapButtonAddEvent), for: .touchUpInside)
        self.buttonAddEvent.layer.cornerRadius = 20
        self.buttonAddEvent.setTitle("Добавить", for: .normal)

        self.buttonAddEvent.clipsToBounds = true
    }
    
    @objc
    func didTapButtonAddEvent() {
        self.output.didTabAddEvent(name: self.textEventName.text,
                                  description: self.textEventDescription.text,
                                  date: self.textDate.date,
                                   place: self.placeText.text)
    }
}

