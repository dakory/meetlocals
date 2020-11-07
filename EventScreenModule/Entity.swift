import UIKit


import UIKit


struct Event {
    var data: String
    var description: String
    var place: String
    
    init(data: String, description: String, place: String) {
        self.data = data
        self.description = description
        self.place = place
    }
}

struct Person {
    var name: String
    var imagePersonString: UIImage?
    var events: Array<Event>
    
    init(name: String, imagePerson: String) {
        self.name = name
        self.imagePersonString = UIImage(named: imagePerson)
        self.events = []
    }
    
}


