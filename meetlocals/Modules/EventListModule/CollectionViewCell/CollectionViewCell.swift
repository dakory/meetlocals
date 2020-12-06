//
//  EventCollectionViewCell.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var eventId: Int
    var height = CGFloat(75)

    fileprivate let UserName: UILabel = { () -> UILabel in
        let UserName = UILabel()
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserName.font = UIFont(name: "Avenir-Light", size: 13)
        UserName.textColor = .systemGray
        UserName.textAlignment = .left
        return UserName
    }()
    
    fileprivate let EventName: UILabel = { () -> UILabel in
        let EventName = UILabel()
        EventName.translatesAutoresizingMaskIntoConstraints = false
        EventName.font = EventName.font.withSize(17)
        EventName.textAlignment = .left
        EventName.lineBreakMode = .byWordWrapping
        EventName.numberOfLines = 0
        return EventName
    }()
    fileprivate let UserImage: UIImageView = { ( ) -> UIImageView in
        let UserImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        UserImage.contentMode = UIView.ContentMode.scaleAspectFill
        UserImage.layer.borderWidth = 0
        UserImage.clipsToBounds = true
        
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        return UserImage
    }()
    
    override init(frame: CGRect) {
        self.eventId = 0
        super.init(frame: frame)
        
        contentView.addSubview(UserImage)
        UserImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        UserImage.bottomAnchor.constraint(equalTo: UserImage.topAnchor, constant: height).isActive = true
        UserImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        UserImage.trailingAnchor.constraint(equalTo: UserImage.leadingAnchor, constant: height).isActive = true
        UserImage.layer.cornerRadius = height / 2
        
        
        contentView.addSubview(UserName)
        UserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        UserName.leadingAnchor.constraint(equalTo: UserImage.leadingAnchor, constant: height + 16).isActive = true
        UserName.bottomAnchor.constraint(equalTo: UserName.topAnchor, constant: 15).isActive = true
        UserName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        
        contentView.addSubview(EventName)
        EventName.topAnchor.constraint(equalTo: UserName.bottomAnchor, constant: 5).isActive = true
        EventName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 15).isActive = true
        EventName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21).isActive = true
        EventName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        EventName.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: EventViewModel, collectionView: UICollectionView, index: Int) {
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == model.idOrganizer })
        let person = Common.profiles.profiles[indexPerson!]
        EventName.text = model.name
        UserName.text = "\(person.name)"
        UserImage.image = UIImage(named: person.avatarUrl!)
        eventId = model.id
    }
}
