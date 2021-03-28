//
//  main.swift
//  Lesson7
//
//  Created by Pauwell on 24.03.2021.
//
import Foundation

struct Person {
    let name: String
    let sex: String
    let age: Int
    let money: Int
}

class People {
    var crowd = [
        "Pavel": Person(name: "Pavel", sex: "man", age: 18, money: 500),
        "Dima": Person(name: "Dima", sex: "man", age: 16, money: 360),
        "Lena": Person(name: "Lena", sex: "woman", age: 20, money: 350),
        "Sasha": Person(name: "Sasha", sex: "man", age: 19, money: 200),
        "Max": Person(name: "Max", sex: "man", age: 17, money: 400)
    ]
    
    let priceticket = 350
    let ageBound = 18
    
    func checkAge (checkName: String) -> Int? {
        guard let checkAge = crowd[checkName] else { return nil }
        return checkAge.age
    }
    
    func whoCanGoToMovie (personName: String) -> String? {
        
        guard let name = crowd[personName] else { return nil }
        guard name.money > priceticket else { return nil }
        guard name.age >= ageBound else { return nil }
        
        return "Вы можите пойти в кино"
    }
}

enum PeopleError: Error {
    
    case nameMistake
    case noMoney(need: Int)
    case troubleAge
    
    var localisedDescription: String {
        switch self {
        case .nameMistake:
            return "Введите имя из списка"
        case .noMoney(need: let money):
            return "Не хватает \(money) р"
        case .troubleAge:
            return "Нет 18 лет"
        }
    }
    
}

extension People {
    
    func peopleError (personName: String) -> (name: String? , error: PeopleError?) {
        
        guard let name = crowd[personName] else {
            return (nil, .nameMistake)
        }
        
        guard name.money > priceticket else {
            return (nil, .noMoney(need: priceticket - name.money))
            
        }
        
        guard name.age >= ageBound else {
            return (nil, .troubleAge)
        }
        
        return (personName, nil)
    }
}

let people = People()

let people1 = people.peopleError(personName: "Pavel")
if let name = people1.name {
    print("\(name) вы проходите")
} else if let error = people1.error {
    print("\(error.localisedDescription)")
}

let people2 = people.peopleError(personName: "Dima")
if let name = people2.name {
    print("\(name) вы проходите")
} else if let error = people2.error {
    print("\(error.localisedDescription)")
}

let people3 = people.peopleError(personName: "Sasha")
if let name = people3.name {
    print("\(name) вы проходите")
} else if let error = people3.error {
    print("\(error.localisedDescription)")
}

let people4 = people.peopleError(personName: "Oly")
if let name = people4.name {
    print("\(name) вы проходите")
} else if let error = people4.error {
    print("\(error.localisedDescription)")
}


extension People {
    
    func peopleThrowError (personName: String) throws -> String {
        
        guard let name = crowd[personName] else {
            throw PeopleError.nameMistake
        }
        
        guard name.money > priceticket else {
            throw PeopleError.noMoney(need: priceticket - name.money)
        }
        
        guard name.age >= ageBound else {
            throw PeopleError.troubleAge
        }
        
        return "\(personName) вы проходите"
    }
}

let people5 = People()

do {
    let peopleThrow = try people5.peopleThrowError(personName: "Dima")
    print(peopleThrow)
} catch PeopleError.nameMistake {
    print("Ошибочное имя")
} catch PeopleError.noMoney(need: let money) {
    print("Не хватает на билет \(money)")
} catch PeopleError.troubleAge {
    print("Слишком мало лет")
} catch {
    print(error)
}


enum SurnameError: Error {
    case surnameError
}

let surname = [
    "Ivanov": "Pavel",
    "Petrov": "Sasha",
    "Cidorov": "Dima"
]

func checkSurname(person: String, people: People) throws -> String {
    
    guard let checkSurname = surname[person] else {
        throw SurnameError.surnameError
    }
    
    return try people.peopleThrowError(personName: checkSurname)
}
    
do {
    _ = try checkSurname(person: "Cidorov", people: people)
    print("Вы проходите")
} catch {
    if let error = error as? PeopleError {
        print(error.localisedDescription)
    }
}


