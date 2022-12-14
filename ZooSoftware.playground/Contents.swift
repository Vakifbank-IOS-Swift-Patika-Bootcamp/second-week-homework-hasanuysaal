import Foundation

/// Enums

enum keepingDifficuality: Double {
    case easy = 0.1, normal = 0.5 , hard = 1.0
}

/// Animal Protocol

protocol Animal {
    
    var name: String {get set}
    var breed: String? {get set}
    var waterConsumption: Double {get set}
    var drinkedWater: Bool {get set}
    var keepingDifficuality: keepingDifficuality {get set}
    var keeper: Keeper? {get set}
    var zoo: Zoo {get set}
    func sound()
    mutating func drinkWater()
    
}

/// Zoo

class Zoo {
    
    var name: String
    var dailyWaterCapacity: Double
    var budget: Double
    var animals: [Animal] = []
    var keepers: [Keeper] = []
    
    init(name: String, dailyWaterCapacity: Double, budget: Double){
        self.name = name
        self.dailyWaterCapacity = dailyWaterCapacity
        self.budget = budget
    }
    
    func setKeepingAnimals(animals: [Animal], keeper: Keeper ){
        for animal in animals {
            var theAnimal = animal
            keeper.keepingAnimals.append(animal)
            theAnimal.keeper = keeper
        }
        
    }
    
    func addIncome(income: Double){
        self.budget = self.budget + income
    }
    
    func addExpense(expense: Double){
        self.budget = self.budget - expense
    }
    
    func incraiseWaterCapacity(with amount: Double){
        self.dailyWaterCapacity = self.dailyWaterCapacity + amount
    }
    
    func decraiseWaterCapacity(with amount: Double) -> Bool {
        
        if (self.dailyWaterCapacity - amount) < 0 {
            print("There is no water to use")
            return false
        } else {
            self.dailyWaterCapacity = self.dailyWaterCapacity - amount
            return true
        }
    }
    
    func paySalary(keeper: Keeper){
        self.budget = self.budget - keeper.salary
    }
    
    func drinkAllAnimals() {
        for animal in self.animals {
            var anml = animal
            anml.drinkWater()
        }
    }
    
}

/// Animals

class Cat: Animal {
    
    var name: String
    var breed: String?
    var waterConsumption: Double
    var drinkedWater = false
    var keepingDifficuality: keepingDifficuality
    var keeper: Keeper?
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.breed = breed
        self.zoo = zoo
    }
    
    func sound() {
        if let breed = self.breed {
            if breed == "Tekir" {
                print("Meoowww")
            }
        } else {
            print("Miyav")
        }
        
    }
    
    func drinkWater() {
        if !self.drinkedWater {
            self.drinkedWater = self.zoo.decraiseWaterCapacity(with: self.waterConsumption)
        }
    }
}

class Dog: Animal {
    
    var name: String
    var breed: String?
    var waterConsumption: Double
    var drinkedWater = false
    var keepingDifficuality: keepingDifficuality
    var keeper: Keeper?
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.zoo = zoo
    }
    
    func sound() {
        print("Havv")
    }
    
    func drinkWater() {
        if !self.drinkedWater {
            self.drinkedWater = self.zoo.decraiseWaterCapacity(with: self.waterConsumption)
        }
    }
}

class Cow: Animal {
    
    var name: String
    var breed: String?
    var waterConsumption: Double
    var drinkedWater = false
    var keepingDifficuality: keepingDifficuality
    var keeper: Keeper?
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.zoo = zoo
    }
    
    func sound() {
        print("M??????")
    }
    
    
    func drinkWater() {
        if !self.drinkedWater {
            self.drinkedWater = self.zoo.decraiseWaterCapacity(with: self.waterConsumption)
        }
    }
}

class Camel: Animal {
    
    var name: String
    var breed: String?
    var waterConsumption: Double
    var drinkedWater = false
    var keepingDifficuality: keepingDifficuality
    var keeper: Keeper?
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.zoo = zoo
    }
    
    func sound() {
        print("Camel's sound...")
    }
    
    func drinkWater() {
        if !self.drinkedWater {
            self.drinkedWater = self.zoo.decraiseWaterCapacity(with: self.waterConsumption)
        } else {
            print("\(self.name) has already drunk water")
        }
    }
}

/// Keeper

class Keeper {
    
    let id = UUID()
    var name: String
    var keepingAnimals : [Animal] = []
    
    init(name: String) {
        self.name = name
    }
    
    // Bak??c??n??n 5250 ??? maa????na bonus olarak bakt?????? hayvanlar??n her biri i??in +500 ??? eklenir.
    // Sonras??nda hesaplanan maa??, bakt?????? hayvanlar??n zorluk katsay??lar??n??n toplam?? ile ??arp??larak tekrar maa??a eklenir.
    // G??ncel maa?? hesaplan??r.
    
    var salary: Double {
        
        var newSalary = 5250.0
        
        newSalary = newSalary + Double(keepingAnimals.count * 500)
        
        let keepingAnimalsDifficulities = (keepingAnimals.map({ $0.keepingDifficuality.rawValue }))
        
        var cofficient = 0.0
        
        for difficulity in keepingAnimalsDifficulities {
            cofficient = cofficient + difficulity
        }
        
        newSalary = newSalary + (newSalary * cofficient)
        
        return newSalary
    }
    
}


// Hayvanat Bah??esi olu??turuldu.
var zoo = Zoo(name: "Hayvanat Bah??esi", dailyWaterCapacity: 1200, budget: 100000)

// Bak??c??lar olu??turuldu.
var keeper1 = Keeper(name: "Hasan")
var keeper2 = Keeper(name: "Ali")

// Hayvanlar olu??turuldu.
var cat1 = Cat(name: "Zeytin", breed: "Tekir", waterConsumption: 60,keepingDifficuality: .easy, zoo: zoo)
var cat2 = Cat(name: "Garfield", waterConsumption: 50,keepingDifficuality: .easy, zoo: zoo)
var cat3 = Cat(name: "??erafettin", waterConsumption: 70,keepingDifficuality: .easy, zoo: zoo)

var dog1 = Dog(name: "Pa??a", waterConsumption: 70, keepingDifficuality: .easy, zoo: zoo)

var cow1 = Cow(name: "Sar??k??z", waterConsumption: 150,keepingDifficuality: .normal, zoo: zoo)

var animals = [cat1, cat2, cat3, dog1, cow1] as [Animal]
var keepers = [keeper1, keeper2]

// Hayvanat bah??esinin bak??c??lar ve hayvanlar propertyleri setlendi.
zoo.keepers = keepers
zoo.animals = animals


// Bak??c??lara bakacaklar?? hayvanlar verildi
zoo.setKeepingAnimals(animals: [cat1, dog1], keeper: keeper1)
zoo.setKeepingAnimals(animals: [cat2, cat3], keeper: keeper2)


// Yeni bak??c?? ve hayvanlar eklendi.
var keeper3 = Keeper(name: "Veli")
var camel1 = Camel(name: "Camel", waterConsumption: 1000,keepingDifficuality: .hard, zoo: zoo)
keepers.append(keeper3)
animals.append(camel1)

zoo.keepers.append(keeper3)
zoo.animals.append(camel1)

zoo.setKeepingAnimals(animals: [camel1], keeper: keeper3)

//--Methodlar??n ve Propertylerin kullan??lmas?? ve test edilmesi--

//Eklenen hayvan??n bak??c??s?? ve ayn?? bak??c??n??n bakt?????? hayvanlar g??r??nt??lendi.
camel1.keeper
keeper3.keepingAnimals

// Hayvanat bah??esindeki t??m hayvanlar g??r??nt??lendi.
zoo.animals

// Hayvanlar??n su ihtiyac?? giderildi ve hayvanat bah??esinin g??nl??k kapasitesinden d??????ld??.
zoo.dailyWaterCapacity
cat1.drinkedWater
zoo.drinkAllAnimals()
cat1.drinkedWater
zoo.dailyWaterCapacity


// Hayvanat bah??esinin su kapasitesi art??r??ld??.
zoo.incraiseWaterCapacity(with: 500.0)

zoo.dailyWaterCapacity
camel1.drinkedWater
zoo.drinkAllAnimals()
camel1.drinkedWater
zoo.dailyWaterCapacity

// Bak??c?? maa??lar?? ??dendi ve hayvanat bah??esi b??t??esinden d??????ld??.
zoo.budget
for keeper in keepers {
    zoo.paySalary(keeper: keeper)
}
zoo.budget

// Hayvanat bah??esine gelir ve gider eklendi.
zoo.budget
zoo.addIncome(income: 10000)
zoo.addExpense(expense: 5000)
zoo.budget

// Di??er baz?? metodlar??n ve propertylerin kullan??lmas??.
keeper1.salary
keeper3.salary

keeper1.name
keeper1.keepingAnimals

cat1.sound()
cat3.sound()

// Hayvanat bah??esi, hayvanlar ve bak??c??lar??n tan??t??lmas??
print("\(zoo.name)'nde \(zoo.animals.count) tane hayvan ve \(zoo.keepers.count) tane bak??c?? bulunmaktad??r.")
print("\(zoo.name)'nin g??nl??k su kapasitesi \(zoo.dailyWaterCapacity)'dir ve b??t??esi ise \(zoo.budget)??? dir.")

print("Bak??c??lardan \(keeper1.name) \(keeper1.keepingAnimals.count) tane hayvana bakmaktad??r.")

print("\(cat1.name) ve \(dog1.name) 'in bak??c??s?? \(cat1.keeper?.name ?? "") 'dir")
