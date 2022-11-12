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
    var keeper: Keeper {get set}
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
    var keeper: Keeper
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, keeper: Keeper, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.keeper = keeper
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
    var keeper: Keeper
    var zoo: Zoo
    
    init(name: String, breed:String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, keeper: Keeper, zoo: Zoo){
        self.name = name
        self.breed = breed
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.keeper = keeper
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
    var keeper: Keeper
    var zoo: Zoo
    
    init(name: String, breed:String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, keeper: Keeper, zoo: Zoo){
        self.name = name
        self.breed = breed
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.keeper = keeper
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
    var keeper: Keeper
    var zoo: Zoo
    
    init(name: String, breed: String? = nil, waterConsumption: Double, keepingDifficuality: keepingDifficuality, keeper: Keeper, zoo: Zoo){
        self.name = name
        self.waterConsumption = waterConsumption
        self.keepingDifficuality = keepingDifficuality
        self.keeper = keeper
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

struct Keeper {

    let id = UUID()
    var name: String
    var keepingAnimals : [Animal] = []
    
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
    
    mutating func setKeepingAnimals(animals: [Animal]){
        for animal in animals {
            if animal.keeper.id == self.id {
                self.keepingAnimals.append(animal)
            }
        }
    }
    
}


// Hayvanat Bahçesi oluşturuldu.
var zoo = Zoo(name: "Hayvanat Bahçesi", dailyWaterCapacity: 1200, budget: 100000)

// Bakıcılar oluşturuldu.
var keeper1 = Keeper(name: "Hasan")
var keeper2 = Keeper(name: "Ali")

// Hayvanlar oluşturuldu.
var cat1 = Cat(name: "Zeytin", breed: "Tekir", waterConsumption: 30,keepingDifficuality: .easy, keeper: keeper1, zoo: zoo) as Animal
var cat2 = Cat(name: "Garfield", waterConsumption: 50,keepingDifficuality: .easy, keeper: keeper2, zoo: zoo) as Animal
var cat3 = cat2

var dog1 = Dog(name: "Paşa", waterConsumption: 70, keepingDifficuality: .easy, keeper: keeper2, zoo: zoo) as Animal

var cow1 = Cow(name: "Sarıkız", waterConsumption: 150,keepingDifficuality: .normal, keeper: keeper1, zoo: zoo) as Animal

var animals = [cat1, cat2, cat3, dog1, cow1]
var keepers = [keeper1, keeper2]

// Hayvanat bahçesinin bakıcılar ve hayvanlar propertyleri setlendi.
zoo.keepers = keepers
zoo.animals = animals

// Bakıcılara bakacakları hayvanlar verildi
keeper1.setKeepingAnimals(animals: animals)
keeper1.keepingAnimals

keeper2.setKeepingAnimals(animals: animals)
keeper2.keepingAnimals


// Yeni bakıcı ve hayvanlar eklendi.
var keeper3 = Keeper(name: "Veli")
var camel1 = Camel(name: "Camel", waterConsumption: 1000,keepingDifficuality: .hard, keeper: keeper3, zoo: zoo)
zoo.keepers.append(keeper3)
zoo.animals.append(camel1)

keeper3.setKeepingAnimals(animals: [camel1])

//--Methodların ve Propertylerin kullanılması ve test edilmesi--

//Eklenen hayvanın bakıcısı ve aynı bakıcının baktığı hayvanlar görüntülendi.
camel1.keeper
keeper3.keepingAnimals

// Hayvanat bahçesindeki tüm hayvanlar görüntülendi.
zoo.animals

// Hayvanların su ihtiyacı giderildi ve hayvanat bahçesinin günlük kapasitesinden düşüldü.
animals.append(camel1)

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
keepers.append(keeper3)

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

print("\(zoo.name)'nde \(zoo.animals.count) tane hayvan ve \(zoo.keepers.count) tane bakıcı bulunmaktadır.")
print("\(zoo.name)'nin günlük su kapasitesi \(zoo.dailyWaterCapacity)'dir ve bütçesi ise \(zoo.budget)₺ dir.")

print("Bakıcılardan \(keeper1.name) \(keeper1.keepingAnimals.count) tane hayvana bakmaktadır.")

print("\(cat2.name), \(cat3.name) ve \(dog1.name) 'in bakıcısı \(cat2.keeper.name) 'dir")
