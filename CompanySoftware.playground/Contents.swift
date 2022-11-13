import Foundation

///Enums

enum MaritalStatus {
    case married, notMarried
}

enum DeveloperLabel: Int {
    case intern = 1, jr, mid, sr, lead, head
}

///Protocols

protocol Company {
    
    var name: String {get set}
    var developers: [SoftwareDeveloper] {get set}
    var budget: Double {get set}
    var foundationYear: Int {get set}
    
    func addIncome(income: Double)
    func addExpense(expense: Double)
    
}

protocol Employee {
    
    var name: String {get set}
    var age: Int {get set}
    var maritalStatus: MaritalStatus? {get set}
    var numOfChilds: Int? {get set}
    
}

///Classes

class SoftwareCompany: Company {
    
    var name: String
    var developers: [SoftwareDeveloper]
    var budget: Double
    var foundationYear: Int
    
    init(name: String, developers: [SoftwareDeveloper], budget: Double, foundationYear: Int){
        self.name = name
        self.developers = developers
        self.budget = budget
        self.foundationYear = foundationYear
    }
    
    func addIncome(income: Double)  {
        
        print("The old budget is \(self.budget)")
        self.budget = self.budget + income
        print("Added \(income) income")
        print("Current budget is \(self.budget)")
        
    }
    
    func addExpense(expense: Double) {
        
        print("The old budget is \(self.budget)")
        self.budget = self.budget - expense
        print("Added \(expense) expense")
        print("Current budget is \(self.budget)")
        
    }
    
    
    func paySalary(developers: [SoftwareDeveloper], completion: (MaritalStatus, SoftwareDeveloper) -> Void ){
        
        for developer in developers {
            
            if !developer.isSalaryPaid {
                if let salary = developer.salary {
                    
                    self.budget = self.budget - salary
                    print("\(developer.name)'s salary is paid")
                    developer.isSalaryPaid = true
                    if let maritalStatus = developer.maritalStatus {
                        completion(maritalStatus, developer)
                    }
                    
                }
                
            } else {
                print("\(developer.name)'s salary has already paid")
            }
        }
        print("current budget is \(self.budget)")
    }
    
    func showSalaries(developers: [SoftwareDeveloper]){
        
        for developer in developers {
            
            if let salary = developer.salary {
                print("\(developer.name)'s salary is \(salary)")
            }
            
        }
    }
    
    func calculateCoefficient(developer: SoftwareDeveloper) -> Double {
        let coefficient = Double(developer.age * developer.label.rawValue) / 100
        return coefficient
    }
    
    func additionalSalary(developer: SoftwareDeveloper, salary: Double) -> Double{
        
        var newSalary = salary
        if let numOfChilds = developer.numOfChilds  {
            newSalary = salary + Double(numOfChilds * 200)
        }
        return newSalary
        
    }
    
    func calculateSalary(developers: [SoftwareDeveloper]) {
        
        for developer in developers {
            var salary = 0.0
            
            switch developer.label {
            case .intern:
                salary = 5000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            case .jr:
                salary = 6000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            case .mid:
                salary = 7000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            case .sr:
                salary = 8000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            case .lead:
                salary = 9000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            case .head:
                salary = 10000
                salary = salary + salary * calculateCoefficient(developer: developer)
                salary = additionalSalary(developer: developer, salary: salary)
                developer.salary = salary
            }
        }
        
        
       
    }
    
}



class SoftwareDeveloper: Employee {
    
    var id: UUID
    var name: String
    var age: Int
    var label: DeveloperLabel
    var maritalStatus: MaritalStatus?
    var numOfChilds: Int?
    var salary: Double?
    var isSalaryPaid = false
    
    init(id: UUID, name: String, age: Int, label: DeveloperLabel, maritalStatus: MaritalStatus? = .notMarried, numOfChilds: Int? = 0){
        self.id = id
        self.name = name
        self.age = age
        self.label = label
        self.maritalStatus = maritalStatus
        self.numOfChilds = numOfChilds
    }
    
}


///Instances

//- Create Company
var patika = SoftwareCompany(name: "Patika.dev", developers: [], budget: 1000000, foundationYear: 2015)

//- Create employees
var sd1 = SoftwareDeveloper(id: UUID(), name: "Hasan", age: 25, label: .jr, maritalStatus: .notMarried, numOfChilds: 0)
var sd2 = SoftwareDeveloper(id: UUID(), name: "Ali", age: 27, label: .mid, maritalStatus: .married, numOfChilds: 1)
var sd3 = SoftwareDeveloper(id: UUID(), name: "Ahmet", age: 33, label: .sr, maritalStatus: .married, numOfChilds: 2)
var sd4 = SoftwareDeveloper(id: UUID(), name: "Mehmet", age: 40, label: .lead, maritalStatus: .notMarried, numOfChilds: 0)
var sd5 = SoftwareDeveloper(id: UUID(), name: "Serkan", age: 45, label: .head, maritalStatus: .married, numOfChilds: 3)
var sd6 = SoftwareDeveloper(id: UUID(), name: "Ayşe", age: 30, label: .mid, maritalStatus: .notMarried, numOfChilds: 0)
var sd7 = SoftwareDeveloper(id: UUID(), name: "Fatma", age: 20, label: .intern, maritalStatus: .notMarried, numOfChilds: 0)

var softwareDevelopers = [sd1, sd2, sd3, sd4, sd5, sd6, sd7]

///Calculate and set the employees' salaries
patika.calculateSalary(developers: softwareDevelopers)

///Getting and Setting properties and Calling methods

//- Adding employees to Company
patika.developers = softwareDevelopers

//- The budget before salary is payid
patika.budget

//- Paying Salaries of employees
patika.paySalary(developers: softwareDevelopers) { maritalStatus, developer in
    if maritalStatus == .married {
        if var salary = developer.salary {
            salary = salary + 500
            developer.salary = salary
        }
    }
}

//- The budget after salary is paid
patika.budget

//- Showing employees' salaries
patika.showSalaries(developers: softwareDevelopers)

//- Adding income and expense to Company
patika.addIncome(income: 1000)
patika.addExpense(expense: 5000)


