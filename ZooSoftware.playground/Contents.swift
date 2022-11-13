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
        print("Mööö")
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
    
    // Bakıcının 5250 ₺ maaşına bonus olarak baktığı hayvanların her biri için +500 ₺ eklenir.
    // Sonrasında hesaplanan maaş, baktığı hayvanların zorluk katsayılarının toplamı ile çarpılarak tekrar maaşa eklenir.
    // Güncel maaş hesaplanır.
    
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
    /*
    mutating func setKeepingAnimals(animals: [Animal]){
        for animal in animals {
            if animal.keeper.id == self.id {
                self.keepingAnimals.append(animal)
            }
        }
    }
     */
    
}


// Hayvanat Bahçesi oluşturuldu.
var zoo = Zoo(name: "Hayvanat Bahçesi", dailyWaterCapacity: 1200, budget: 100000)

// Bakıcılar oluşturuldu.
var keeper1 = Keeper(name: "Hasan")
var keeper2 = Keeper(name: "Ali")

// Hayvanlar oluşturuldu.
var cat1 = Cat(name: "Zeytin", breed: "Tekir", waterConsumption: 60,keepingDifficuality: .easy, zoo: zoo)
var cat2 = Cat(name: "Garfield", waterConsumption: 50,keepingDifficuality: .easy, zoo: zoo)
var cat3 = Cat(name: "Şerafettin", waterConsumption: 70,keepingDifficuality: .easy, zoo: zoo)

var dog1 = Dog(name: "Paşa", waterConsumption: 70, keepingDifficuality: .easy, zoo: zoo)

var cow1 = Cow(name: "Sarıkız", waterConsumption: 150,keepingDifficuality: .normal, zoo: zoo)

var animals = [cat1, cat2, cat3, dog1, cow1] as [Animal]
var keepers = [keeper1, keeper2]

// Hayvanat bahçesinin bakıcılar ve hayvanlar propertyleri setlendi.
zoo.keepers = keepers
zoo.animals = animals


// Bakıcılara bakacakları hayvanlar verildi
zoo.setKeepingAnimals(animals: [cat1, dog1], keeper: keeper1)
zoo.setKeepingAnimals(animals: [cat2, cat3], keeper: keeper2)


// Yeni bakıcı ve hayvanlar eklendi.
var keeper3 = Keeper(name: "Veli")
var camel1 = Camel(name: "Camel", waterConsumption: 1000,keepingDifficuality: .hard, zoo: zoo)
keepers.append(keeper3)
animals.append(camel1)

zoo.keepers.append(keeper3)
zoo.animals.append(camel1)

zoo.setKeepingAnimals(animals: [camel1], keeper: keeper3)

//--Methodların ve Propertylerin kullanılması ve test edilmesi--

//Eklenen hayvanın bakıcısı ve aynı bakıcının baktığı hayvanlar görüntülendi.
camel1.keeper
keeper3.keepingAnimals

// Hayvanat bahçesindeki tüm hayvanlar görüntülendi.
zoo.animals

// Hayvanların su ihtiyacı giderildi ve hayvanat bahçesinin günlük kapasitesinden düşüldü.
zoo.dailyWaterCapacity
cat1.drinkedWater
zoo.drinkAllAnimals()
cat1.drinkedWater
zoo.dailyWaterCapacity


// Hayvanat bahçesinin su kapasitesi artırıldı.
zoo.incraiseWaterCapacity(with: 500.0)

zoo.dailyWaterCapacity
camel1.drinkedWater
zoo.drinkAllAnimals()
camel1.drinkedWater
zoo.dailyWaterCapacity

// Bakıcı maaşları ödendi ve hayvanat bahçesi bütçesinden düşüldü.
zoo.budget
for keeper in keepers {
    zoo.paySalary(keeper: keeper)
}
zoo.budget

// Hayvanat bahçesine gelir ve gider eklendi.
zoo.budget
zoo.addIncome(income: 10000)
zoo.addExpense(expense: 5000)
zoo.budget

// Diğer bazı metodların ve propertylerin kullanılması.
keeper1.salary
keeper3.salary

keeper1.name
keeper1.keepingAnimals

cat1.sound()
cat3.sound()

// Hayvanat bahçesi, hayvanlar ve bakıcıların tanıtılması
print("\(zoo.name)'nde \(zoo.animals.count) tane hayvan ve \(zoo.keepers.count) tane bakıcı bulunmaktadır.")
print("\(zoo.name)'nin günlük su kapasitesi \(zoo.dailyWaterCapacity)'dir ve bütçesi ise \(zoo.budget)₺ dir.")

print("Bakıcılardan \(keeper1.name) \(keeper1.keepingAnimals.count) tane hayvana bakmaktadır.")

print("\(cat1.name) ve \(dog1.name) 'in bakıcısı \(cat1.keeper?.name ?? "") 'dir")
