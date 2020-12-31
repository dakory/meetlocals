


class Sun {
    var isNova = false
     func goNova(){
        isNova = true
    }
}

let sun = Sun()
sun.goNova()


protocol Washable {
    var dirtinessLevel: Int { get }
}

class Car: Washable{
    var dirtinessLevel: Int

    init(hmm: Int) {
        self.dirtinessLevel = hmm
    }
}

var car = Car(hmm: 4)
car.dirtinessLevel = 39

print(car.dirtinessLevel)


protocol PersonProtocol {
    var firstName: String { get }
}

struct Person: PersonProtocol {
    var firstName: String
}

protocol Ridable {}
protocol Trainable {}
protocol Dog: Trainable {}




enum Kek {
    case right, left
}

var kok = Kek.left

switch kok {
case Kek.left:
    print("эээ, налево уходи")
default:
    print(2)
}
