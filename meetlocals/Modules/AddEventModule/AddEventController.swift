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
    private let eventNameLabel = UILabel()
    private let textEventName = UITextView()
    private let dateTimeLabel = UILabel()
    private let textDate = UIDatePicker()
    private let placeLabel = UILabel()
    private let placeText = UITextView()
    private let textEventLabel = UILabel()
    private let textEventDescription = UITextView()
    private let buttonAddEvent = UIButton()
    private let scrollView = UIScrollView()
    var textEventNameHeightConstraint: NSLayoutConstraint!
    var placeTextHeightConstraint: NSLayoutConstraint!
    var textEventDescriptionNameHeightConstraint: NSLayoutConstraint!
    var addToScroll: CGFloat!
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        self.tabBarItem =
           UITabBarItem(
            title: "Новое событие",
            image: UIImage(systemName: "plus"),
            tag: 2)
        self.navigationItem.title = "Новое событие"
        
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    }

    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height - view.safeAreaInsets.bottom + scrollView.convert(textEventDescription.frame.origin, to: buttonAddEvent).y)
        }
}


extension AddEventViewController: AddEventViewInput {
    func cleanScreen() { //эту функция очищения полей, вызываем после добавления мероприятия
        textEventName.text = ""
        textEventDescription.text = ""
        placeText.text = ""
        textViewDidChange(placeText)
        textViewDidChange(textEventName)
        textViewDidChange(textEventDescription)
    }
}



private extension AddEventViewController {
    func addAll(_ view: UIView) {
        scrollView.addSubview(eventNameLabel)
        scrollView.addSubview(textEventName)
        scrollView.addSubview(dateTimeLabel)
        scrollView.addSubview(textDate)
        scrollView.addSubview(placeLabel)
        scrollView.addSubview(textEventLabel)
        scrollView.addSubview(textEventDescription)
        scrollView.addSubview(placeText)
        view.addSubview(scrollView)
        view.addSubview(buttonAddEvent)
    }
    func setupAll() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
        
        
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.font.withSize(14)
        eventNameLabel.textColor = #colorLiteral(red: 0.329372257, green: 0.3294344842, blue: 0.3293683231, alpha: 1)
        eventNameLabel.text = "Название"
        
        [
        eventNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
        eventNameLabel.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 39),
        eventNameLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        eventNameLabel.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ].forEach({$0.isActive = true})
        
        textEventName.translatesAutoresizingMaskIntoConstraints = false
        textEventName.backgroundColor = #colorLiteral(red: 0.9371530414, green: 0.9373136759, blue: 0.9371429086, alpha: 1)
        textEventName.font = .systemFont(ofSize: 20)
        textEventName.placeholder = "Поездка на велосипеде"
        textEventName.delegate = self
        textEventName.layer.cornerRadius = 15
        self.textEventNameHeightConstraint = textEventName.heightAnchor.constraint(equalToConstant: 19)
        [
        textEventName.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 8),
        self.textEventNameHeightConstraint,
        textEventName.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        textEventName.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor),
        ].forEach({$0.isActive = true})
        textEventName.textContainer.lineBreakMode = .byTruncatingTail
        
        
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.font.withSize(14)
        dateTimeLabel.textColor = #colorLiteral(red: 0.3236899972, green: 0.3337572813, blue: 0.3291268349, alpha: 1)
        dateTimeLabel.text = "Дата и время"
        [
        dateTimeLabel.topAnchor.constraint(equalTo: textEventName.bottomAnchor, constant: 28),
        dateTimeLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        dateTimeLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor),
        dateTimeLabel.bottomAnchor.constraint(equalTo: textEventName.bottomAnchor, constant: 47),
        ].forEach({$0.isActive = true})

        
        
        textDate.translatesAutoresizingMaskIntoConstraints = false
        textDate.locale = Locale(identifier: "ru_RU")
        textDate.datePickerMode = .dateAndTime
        textDate.preferredDatePickerStyle = .wheels
        textDate.minimumDate = { () -> Date in
            let calendar = Calendar(identifier: .gregorian)
            var components = DateComponents()
            components.hour = 1
            let minDate = calendar.date(byAdding: components, to: Date())
            return minDate!
        }()
        [
        textDate.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 8),
        textDate.bottomAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 100),
        textDate.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        textDate.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor),
        ].forEach({$0.isActive = true})
        textDate.layer.cornerRadius = 15
        
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.font.withSize(14)
        placeLabel.textColor = #colorLiteral(red: 0.329372257, green: 0.3294344842, blue: 0.3293683231, alpha: 1)
        placeLabel.text = "Местоположение"
        [
        placeLabel.topAnchor.constraint(equalTo: textDate.bottomAnchor, constant: 28),
        placeLabel.bottomAnchor.constraint(equalTo: textDate.bottomAnchor, constant: 28 + 19),
        placeLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        placeLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor)
        ].forEach({$0.isActive = true})

        
        placeText.translatesAutoresizingMaskIntoConstraints = false
        placeText.backgroundColor = #colorLiteral(red: 0.9371530414, green: 0.9373136759, blue: 0.9371429086, alpha: 1)
        placeText.font = .systemFont(ofSize: 20)
        placeText.placeholder = "Парк Лосиный остров, главный вход"
        self.placeTextHeightConstraint = placeText.heightAnchor.constraint(equalToConstant: 19)
        placeText.delegate = self
        placeText.layer.cornerRadius = 15
        [
        placeText.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 8),
        self.placeTextHeightConstraint,
        placeText.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        placeText.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor)
        ].forEach({$0.isActive = true})
        placeText.textContainer.lineBreakMode = .byTruncatingTail
        
        
        textEventLabel.translatesAutoresizingMaskIntoConstraints = false
        textEventLabel.font.withSize(14)
        textEventLabel.textColor = #colorLiteral(red: 0.329372257, green: 0.3294344842, blue: 0.3293683231, alpha: 1)
        textEventLabel.text = "Описание"
        [
        textEventLabel.topAnchor.constraint(equalTo: placeText.bottomAnchor, constant: 28),
        textEventLabel.bottomAnchor.constraint(equalTo: textEventLabel.topAnchor, constant: 19),
        textEventLabel.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        textEventLabel.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor)
        ].forEach({$0.isActive = true})
        
        

        
        textEventDescription.translatesAutoresizingMaskIntoConstraints = false
        textEventDescription.backgroundColor = #colorLiteral(red: 0.9371530414, green: 0.9373136759, blue: 0.9371429086, alpha: 1)
        textEventDescription.font = .systemFont(ofSize: 20)
        textEventDescription.placeholder = "Присоединяйся ко мне :)"
        textEventDescription.delegate = self
        textEventDescription.layer.cornerRadius = 15
        self.textEventDescriptionNameHeightConstraint = textEventDescription.heightAnchor.constraint(equalToConstant: 19)
        placeText.delegate = self
        [
        textEventDescription.topAnchor.constraint(equalTo: textEventLabel.bottomAnchor, constant: 8),
        self.textEventDescriptionNameHeightConstraint,
        textEventDescription.leadingAnchor.constraint(equalTo: eventNameLabel.leadingAnchor),
        textEventDescription.trailingAnchor.constraint(equalTo: eventNameLabel.trailingAnchor)
        ].forEach({$0.isActive = true})
        textEventDescription.textContainer.lineBreakMode = .byTruncatingTail
        
        
        buttonAddEvent.translatesAutoresizingMaskIntoConstraints = false
        buttonAddEvent.backgroundColor = #colorLiteral(red: 0.2197580338, green: 0.4078575969, blue: 0.901501596, alpha: 1)
        buttonAddEvent.addTarget(self, action: #selector(didTapButtonAddEvent), for: .touchUpInside)
        buttonAddEvent.layer.cornerRadius = 20
        buttonAddEvent.setTitle("Добавить", for: .normal)
        buttonAddEvent.clipsToBounds = true
        [
        buttonAddEvent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
        buttonAddEvent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -79),
        buttonAddEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 37),
        buttonAddEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -37)
        ].forEach({$0.isActive = true})
        
        
        self.addToScroll = 19
        self.adjustTextViewHeightForTextEventName()
        self.adjustTextViewHeightForTextEventDescription()
        self.adjustTextViewHeightForPlaceText()
    }

    
    func adjustTextViewHeightForTextEventName() {
        let fixedWidth = textEventName.frame.size.width
        let newSize = textEventName.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        scrollView.contentSize.height -= self.textEventNameHeightConstraint.constant - newSize.height
        self.textEventNameHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    func adjustTextViewHeightForTextEventDescription() {
        let fixedWidth = textEventDescription.frame.size.width
        let newSize = textEventDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        scrollView.contentSize.height -= self.textEventDescriptionNameHeightConstraint.constant - newSize.height
        self.textEventDescriptionNameHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    func adjustTextViewHeightForPlaceText() {
        let fixedWidth = placeText.frame.size.width
        let newSize = placeText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        scrollView.contentSize.height -= self.placeTextHeightConstraint.constant - newSize.height
        self.placeTextHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    
    @objc
    func didTapButtonAddEvent() {
        output.didTabAddEvent(name: textEventName.text,
                                  description: textEventDescription.text,
                                  date: textDate.date,
                                   place: placeText.text)
    }
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        if (deltaY != 0) {
                UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
                    self.buttonAddEvent.frame.origin.y += deltaY + (self.view.safeAreaInsets.bottom) * (deltaY < 0 ? 1: -1)
    }, completion: nil)
            scrollView.contentSize.height -= deltaY  + (self.view.safeAreaInsets.bottom) * (deltaY < 0 ? 1: -1)
            
        }
    }
}

extension AddEventViewController {
    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeightForTextEventName()
        self.adjustTextViewHeightForPlaceText()
        self.adjustTextViewHeightForTextEventDescription()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

