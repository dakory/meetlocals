//
//  AddEventController.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class AddEventViewController: UIViewController, UITextViewDelegate {
    private let output: AddEventViewOutput
    private let wantLabel = UILabel()
    private let textEventName = UITextView()
    private let textEventDescription = UITextView()
    private let textDate = UIDatePicker()
    private let dateLabel = UILabel()
    private let placeLabel = UILabel()
    private let placeText = UITextView()
    private let buttonAddEvent = UIButton(type: .custom)

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
    }
}


extension AddEventViewController: AddEventViewInput {
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
        self.wantLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
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
        self.textEventName.textColor = UIColor.lightGray
        self.textEventName.font = .systemFont(ofSize: 20)
        self.textEventName.text = "Опишите кратко"
        self.textEventName.becomeFirstResponder()
        self.textEventName.delegate = self
        self.textEventName.layer.cornerRadius = 10.0
        self.textEventName.selectedTextRange = self.textEventName.textRange(from: self.textEventName.beginningOfDocument, to: self.textEventName.beginningOfDocument)
        
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
        self.textEventDescription.textColor = UIColor.lightGray
        self.textEventDescription.text = "А здесь подробнее"
        self.textEventDescription.becomeFirstResponder()
        self.textEventDescription.layer.cornerRadius = 10.0
        self.textEventDescription.selectedTextRange = self.textEventDescription.textRange(from: self.textEventDescription.beginningOfDocument, to: self.textEventDescription.beginningOfDocument)
        
    }
    
    func setupDateText() {
        self.textDate.topAnchor.constraint(equalTo: self.textEventDescription.bottomAnchor, constant: 15).isActive = true
        self.textDate.bottomAnchor.constraint(equalTo: self.dateLabel.topAnchor, constant: 30).isActive = true
        self.textDate.trailingAnchor.constraint(equalTo: self.textEventName.trailingAnchor, constant: 0).isActive = true
        self.textDate.leadingAnchor.constraint(equalTo: self.textEventName.leadingAnchor, constant: 0).isActive = true
        self.textDate.translatesAutoresizingMaskIntoConstraints = false
        
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
    }
    
    func setupPlaceText() {
        self.placeText.topAnchor.constraint(equalTo: self.placeLabel.topAnchor, constant: 0).isActive = true
        self.placeText.bottomAnchor.constraint(equalTo: self.placeText.topAnchor, constant: 75).isActive = true
        self.placeText.trailingAnchor.constraint(equalTo: self.textEventName.trailingAnchor, constant: 0).isActive = true
        self.placeText.leadingAnchor.constraint(equalTo: self.textEventName.leadingAnchor, constant: 0).isActive = true
        self.placeText.translatesAutoresizingMaskIntoConstraints = false
        self.placeText.delegate = self
        self.placeText.textColor = UIColor.lightGray
        self.placeText.selectedTextRange = self.placeText.textRange(from: self.placeText.beginningOfDocument, to: self.placeText.beginningOfDocument)
        self.placeText.text = "Место"
        self.placeText.font = .systemFont(ofSize: 20)
        self.placeText.layer.cornerRadius = 10.0
        self.placeText.becomeFirstResponder()
        self.placeText.backgroundColor = #colorLiteral(red: 0.9017923474, green: 0.9021018744, blue: 0.89753896, alpha: 1)
        
    }
    func setupButtonAddEvent() {
        self.buttonAddEvent.translatesAutoresizingMaskIntoConstraints = false
        self.buttonAddEvent.backgroundColor = .blue
        self.buttonAddEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        self.buttonAddEvent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        self.buttonAddEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -UIScreen.main.bounds.height/8).isActive = true
        self.buttonAddEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIScreen.main.bounds.height/8).isActive = true
        
        self.buttonAddEvent.addTarget(self, action: #selector(didTapButtonAddEvent), for: .touchUpInside)
        self.buttonAddEvent.setImage(UIImage(named: "plus"), for: .normal)
        self.buttonAddEvent.layer.cornerRadius = UIScreen.main.bounds.height / 20
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

extension AddEventViewController {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if updatedText.isEmpty {
            textView.text = "Введите что-нибудь"
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
         else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
}


