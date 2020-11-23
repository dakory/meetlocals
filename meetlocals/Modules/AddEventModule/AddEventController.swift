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
    private let scrollView: UIScrollView = {
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return scrollView
    }()

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
        super.viewDidLoad()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
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
        scrollView.addSubview(wantLabel)
        scrollView.addSubview(textEventName)
        scrollView.addSubview(textEventDescription)
        scrollView.addSubview(textDate)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(placeText)
        scrollView.addSubview(placeLabel)
        view.addSubview(scrollView)
        view.addSubview(buttonAddEvent)
        view.layoutIfNeeded()
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
        wantLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        wantLabel.bottomAnchor.constraint(equalTo: wantLabel.topAnchor, constant: 30).isActive = true
        wantLabel.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        wantLabel.trailingAnchor.constraint(equalTo: wantLabel.leadingAnchor, constant: 55).isActive = true
        wantLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        wantLabel.text = "Я хочу"
    }
    
    func setupTextEventName() {
        textEventName.topAnchor.constraint(equalTo: wantLabel.topAnchor, constant: 0).isActive = true
        textEventName.bottomAnchor.constraint(equalTo: wantLabel.bottomAnchor, constant: 30).isActive = true
        textEventName.leadingAnchor.constraint(equalTo: wantLabel.trailingAnchor, constant: 15).isActive = true
        textEventName.trailingAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        textEventName.translatesAutoresizingMaskIntoConstraints = false
        
        
        textEventName.backgroundColor = #colorLiteral(red: 0.9026893973, green: 0.8979343176, blue: 0.8978550434, alpha: 1)
        textEventName.font = .systemFont(ofSize: 20)
        textEventName.placeholder = "Опишите кратко"
        textEventName.delegate = self
        textEventName.layer.cornerRadius = 10.0
    }
    
    func setupTextEventDescription() {
        textEventDescription.topAnchor.constraint(equalTo: textEventName.bottomAnchor, constant: 40).isActive = true
        textEventDescription.bottomAnchor.constraint(equalTo: textEventDescription.topAnchor, constant: 200).isActive = true
        textEventDescription.leadingAnchor.constraint(equalTo: wantLabel.leadingAnchor, constant: 0).isActive = true
        textEventDescription.trailingAnchor.constraint(equalTo: textEventName.trailingAnchor, constant: 0).isActive = true
        textEventDescription.translatesAutoresizingMaskIntoConstraints = false
        
        
        textEventDescription.backgroundColor =  #colorLiteral(red: 0.9035104513, green: 0.8938501477, blue: 0.8938568234, alpha: 1)
        textEventDescription.delegate = self
        textEventDescription.font = .systemFont(ofSize: 20)
        textEventDescription.placeholder = "А здесь подробнее"
        textEventDescription.becomeFirstResponder()
        textEventDescription.layer.cornerRadius = 10.0
    }
    
    func setupDateText() {
        textDate.topAnchor.constraint(equalTo: textEventDescription.bottomAnchor, constant: 15).isActive = true
        textDate.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 30).isActive = true
        textDate.trailingAnchor.constraint(equalTo: textEventName.trailingAnchor, constant: 0).isActive = true
        textDate.leadingAnchor.constraint(equalTo: textEventName.leadingAnchor, constant: 0).isActive = true
        textDate.translatesAutoresizingMaskIntoConstraints = false
        
        textDate.minimumDate = { () -> Date in
            let calendar = Calendar(identifier: .gregorian)
            var components = DateComponents()
            components.hour = 1
            let minDate = calendar.date(byAdding: components, to: Date())
            return minDate!
        }()
        textDate.backgroundColor =  #colorLiteral(red: 0.9035104513, green: 0.8938501477, blue: 0.8938568234, alpha: 1)
    }
    
    func setupDateLabel() {
        dateLabel.topAnchor.constraint(equalTo: textDate.topAnchor, constant: 0).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: textDate.bottomAnchor, constant: 0).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: wantLabel.leadingAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: wantLabel.trailingAnchor, constant: 0).isActive = true
        dateLabel.text = "Когда?"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPlaceLabel() {
        placeLabel.topAnchor.constraint(equalTo: textDate.bottomAnchor, constant: 15).isActive = true
        placeLabel.bottomAnchor.constraint(equalTo: placeLabel.topAnchor, constant: 30).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: wantLabel.leadingAnchor, constant: 0).isActive = true
        placeLabel.trailingAnchor.constraint(equalTo: wantLabel.trailingAnchor, constant: 0).isActive = true
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.text = "Где?"
        placeText.placeholder = "Место"
    }
    
    func setupPlaceText() {
        placeText.topAnchor.constraint(equalTo: placeLabel.topAnchor, constant: 0).isActive = true
        placeText.bottomAnchor.constraint(equalTo: placeText.topAnchor, constant: 75).isActive = true
        placeText.trailingAnchor.constraint(equalTo: textEventName.trailingAnchor, constant: 0).isActive = true
        placeText.leadingAnchor.constraint(equalTo: textEventName.leadingAnchor, constant: 0).isActive = true
        
        
        placeText.translatesAutoresizingMaskIntoConstraints = false
        placeText.delegate = self
        placeText.font = .systemFont(ofSize: 20)
        placeText.layer.cornerRadius = 10.0
        placeText.becomeFirstResponder()
        placeText.backgroundColor =  #colorLiteral(red: 0.9035104513, green: 0.8938501477, blue: 0.8938568234, alpha: 1)
        
    }
    func setupButtonAddEvent() {
        buttonAddEvent.translatesAutoresizingMaskIntoConstraints = false
        buttonAddEvent.backgroundColor = .blue
        buttonAddEvent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        buttonAddEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        buttonAddEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        buttonAddEvent.addTarget(self, action: #selector(didTapButtonAddEvent), for: .touchUpInside)
        buttonAddEvent.layer.cornerRadius = 20
        buttonAddEvent.setTitle("Добавить", for: .normal)

        buttonAddEvent.clipsToBounds = true
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
//            self.scrollView.contentSize.height -= deltaY
            self.buttonAddEvent.frame.origin.y += deltaY + (self.view.safeAreaInsets.bottom) * (deltaY < 0 ? 1: -1)
            self.view.layoutIfNeeded()
    }, completion: nil)
        }
        self.view.layoutIfNeeded()
    }
}

