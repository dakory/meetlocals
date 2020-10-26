//
//  EventCollectionViewCell.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    fileprivate let UserName: UILabel = { () -> UILabel in
        let UserName = UILabel()
        UserName.translatesAutoresizingMaskIntoConstraints = false
        UserName.font = UserName.font.withSize(15)
        UserName.textAlignment = .left
        UserName.text = "Аня"
        return UserName
    }()
    
    fileprivate let EventDescription: UILabel = { () -> UILabel in
        let EventDescription = UILabel()
        EventDescription.translatesAutoresizingMaskIntoConstraints = false
        EventDescription.font = EventDescription.font.withSize(17)
        EventDescription.textAlignment = .left
        return EventDescription
    }()
    fileprivate let UserImage: UIImageView = { ( ) -> UIImageView in
        let UserImage = UIImageView()
        
        UserImage.contentMode = UIView.ContentMode.scaleAspectFill
        UserImage.layer.borderWidth = 1.5
        UserImage.clipsToBounds = true
        UserImage.translatesAutoresizingMaskIntoConstraints = false
        UserImage.image = UIImage(named: "userimage")
        
        return UserImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(UserImage)
        UserImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        UserImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        UserImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        UserImage.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.bounds.height + 5).isActive = true
        UserImage.layer.cornerRadius = self.bounds.height / 2
        
        contentView.addSubview(UserName)
        UserName.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        UserName.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 15).isActive = true
        
        contentView.addSubview(EventDescription)
        EventDescription.topAnchor.constraint(equalTo: UserName.bottomAnchor, constant: 20).isActive = true
        EventDescription.leadingAnchor.constraint(equalTo: UserImage.trailingAnchor, constant: 15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: EventViewModel, collectionView: UICollectionView, index: Int) {
        EventDescription.text = model.description
    }
}
