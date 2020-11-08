//
//  EventCollectionViewCell.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
//    TODO: привязать к ячейке id
//    var eventId: Int
    
    fileprivate let UserName: UILabel = { () -> UILabel in
        let UserName = UILabel()
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserName.font = UserName.font.withSize(15)
        UserName.textAlignment = .left
  //      UserName.text = "Аня"
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
        let UserImage = UIImageView()
        
        UserImage.contentMode = UIView.ContentMode.scaleAspectFill
        UserImage.layer.borderWidth = 1.5
        UserImage.clipsToBounds = true
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        
        return UserImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        eventId = eventId;
        contentView.addSubview(UserImage)
        UserImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        UserImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        UserImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        UserImage.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.height + 5).isActive = true
        UserImage.layer.cornerRadius = self.bounds.height / 2
        
        contentView.addSubview(UserName)
        UserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        UserName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 15).isActive = true
        UserName.bottomAnchor.constraint(equalTo: UserName.topAnchor, constant: 15).isActive = true
        UserName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(EventName)
        EventName.topAnchor.constraint(equalTo: UserName.bottomAnchor, constant: 5).isActive = true
        EventName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 15).isActive = true
        EventName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        EventName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: EventViewModel, collectionView: UICollectionView, index: Int) {
//        print(model.name)
//        print(model.userName)
//        print(model.userImage)
        print(model)
        let indexPerson = Common.profiles.profiles.firstIndex(where: { $0.id == model.idOrganizer })
        let person = Common.profiles.profiles[indexPerson!]
        EventName.text = model.name
        UserName.text = "\(person.name) \(person.surname)"
        UserImage.image = UIImage(named: person.avatarUrl!)
//        eventId = model.id
    }
}
