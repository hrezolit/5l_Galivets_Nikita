//
//  main.swift
//  5l_Galivets_Nikita
//
//  Created by Nikita on 18/2/22.
//

import Foundation

//MARK: - 1) Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

enum Color {
    case white
    case yellow
    case orange
    case green
    case blue
    case pink
    case red
    case black
    case silver
}
enum Engine {
    case start
    case stop
}
enum Windows {
    case open
    case close
}

enum Trunk {
    case putInTrunk
    case takeFromTrunk
}
protocol Carable {
    
    var brand: String { get }
    var model: String { get }
    var color: Color { get }
    var isEngineWork: Engine { get set }
    var isWindowsOpen: Windows { get set }
    var trunkFullness: UInt { get set }
    var trunkVolume: UInt { get set }
    
    mutating func trunkAction(type: Trunk)
    mutating func windowsAction(type: Windows)
    mutating func engineAction(type: Engine)
    
}

//MARK: - 2) Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Carable {
    
    ///Окна Открытие/Закрытие
    mutating func windowsAction(type: Windows) {
        switch type {
        case .open:
            isWindowsOpen = .open
            print("Windows were opened")
        case .close:
            isWindowsOpen = .close
            print("Windows were closed")
        }
    }
    
    ///Багажник Положить/Взять
    mutating func trunkAction(type: Trunk) {
        switch type {
        case .putInTrunk:
            trunkVolume += 50
        case .takeFromTrunk:
            trunkVolume -= 50
        }
    }
    ///Запуск/Остановка двигателя
    mutating func engineAction(type: Engine) {
        switch type {
        case .start:
            isEngineWork = .start
            print("Car engine is power on")
        case .stop:
            isEngineWork = .stop
            print("Car engine is power off")
        }
    }
}

//MARK: - 3) Создать два класса, имплементирующих протокол «Car»: tunkCar и sportCar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
// 4) Для каждого класса написать расширение, имплементирующее протокол «CustomStringConvertible».

// 5) Создать несколько объектов каждого класса. Применить к ним различные действия.

// 6) Вывести сами объекты в консоль.


/// 1) Выриант class SportCar
final class SportCar: Carable, CustomStringConvertible {
    
    enum isTurboExist {
        case set
        case remove
    }
    
    enum isBackseatExist {
        case with
        case without
    }
    
    var brand: String
    var model: String
    var color: Color
    var isEngineWork: Engine
    var isWindowsOpen: Windows
    var trunkFullness: UInt
    var trunkVolume: UInt
    let turboBoosting: UInt = 100
    var description: String {
        return """

            Car description:

    Brand: \(brand)
    Model: \(model)
    Body color: \(color)
    Engind: \(isEngineWork)
    Max speed: \(maxSpeed)
    Turbo: \(turboCondition)
    Windows: \(isWindowsOpen)
    Backseat: \(backseat)
    Trunk space: \(trunkFullness)

                Actions:

"""
    }
    
    private var turboCondition: isTurboExist
    private let backseat: isBackseatExist
    private var maxSpeed: UInt {
        didSet {
            if  maxSpeed < 400 {
                maxSpeed = oldValue
            } else if maxSpeed > 500 {
                maxSpeed = oldValue
            }
        }
    }
    
    
    
    init(brand: String,
         model: String,
         color: Color,
         isEngineWork: Engine,
         isWindowsOpen: Windows,
         trunkFullness: UInt,
         trunkVolume: UInt,
         maxSpeed: UInt,
         turbo: isTurboExist,
         backseat: isBackseatExist) {
        
        self.maxSpeed = maxSpeed
        self.turboCondition = turbo
        self.backseat = backseat
        self.brand = brand
        self.model = model
        self.color = color
        self.trunkFullness = trunkFullness
        self.trunkVolume = trunkVolume
        self.isEngineWork = isEngineWork
        self.isWindowsOpen = isWindowsOpen
        
    }
    
    func setUpTurbo(type: isTurboExist) {
        
        switch type {
        case .set:
            turboCondition = .set
            maxSpeed += turboBoosting
            print("With turbo, max speed up by \(maxSpeed) km/h")
        case .remove:
            turboCondition = .remove
            maxSpeed -= turboBoosting
            print("Without turbo, max speed dicrease by \(maxSpeed) km/h")
            
        }
    }
}

///Экземпляр класса  SportCar
var tesla = SportCar(brand: "Tesla",
                     model: "Roadster",
                     color: .red,
                     isEngineWork: .stop,
                     isWindowsOpen: .close,
                     trunkFullness: 150,
                     trunkVolume: 50,
                     maxSpeed: 400,
                     turbo: .remove,
                     backseat: .without)

let teslaDescription = tesla.description
print(teslaDescription)

tesla.windowsAction(type: .open)
tesla.engineAction(type: .start)
tesla.trunkAction(type: .putInTrunk)
tesla.setUpTurbo(type: .set)
tesla.setUpTurbo(type: .set)
tesla.setUpTurbo(type: .set)
tesla.setUpTurbo(type: .remove)
tesla.setUpTurbo(type: .remove)
tesla.setUpTurbo(type: .remove)

print("""

****************************************

""")

final class Truck: Carable, CustomStringConvertible{
    
    enum  HindcarrigeCondition{
        case set
        case remove
    }
    
    var brand: String
    var model: String
    var color: Color
    var isEngineWork: Engine
    var isWindowsOpen: Windows
    var trunkVolume: UInt
    var trunkFullness: UInt
    var isHindcarrigeExist: HindcarrigeCondition
    var description: String {
        return """
            Car description:

    Brand: \(brand)
    Model: \(model)
    Body color: \(color)
    Engind: \(isEngineWork)
    Windows: \(isWindowsOpen)
    Trunk space: \(trunkFullness)
    Hindcarrige space: \(hindcarrigeFullness)

                Actions:

"""
    }
    
    lazy var overallVolume = hindcarrigeFullness + trunkFullness
    
    private let hindcarrigeFullness: UInt
    private var hindcarriageVolume: UInt {
        didSet {
            if hindcarriageVolume > hindcarrigeFullness {
                hindcarriageVolume = oldValue
                print("Hindcarrige is full!")
            } else if hindcarriageVolume == 0 {
                hindcarriageVolume = oldValue
                print("Hindcarrige is empty")
            } else {
                print("Hindcarrige free space (\(hindcarriageVolume) / \(hindcarrigeFullness)) liters")
            }
        }
    }
    
    init(brand: String,
         model: String,
         color: Color,
         isEngineWork: Engine,
         isWindowsOpen: Windows,
         trunkFullness: UInt,
         trunkVolume: UInt,
         isHindcarrigeExist: HindcarrigeCondition,
         hindcarrigeFullness: UInt,
         hindcarriageVolume: UInt,
         description: String) {
        
        self.brand = brand
        self.model = model
        self.color = color
        self.isEngineWork = isEngineWork
        self.isWindowsOpen = isWindowsOpen
        self.trunkVolume = trunkVolume
        self.trunkFullness = trunkFullness
        self.isHindcarrigeExist = isHindcarrigeExist
        self.hindcarrigeFullness = hindcarrigeFullness
        self.hindcarriageVolume = hindcarriageVolume
        
    }
}

///Экземпляр класса  Truck
var teslaTruck = Truck(brand: "Tesla",
                       model: "Semi",
                       color: .silver,
                       isEngineWork: .start,
                       isWindowsOpen: .close,
                       trunkFullness: 3000,
                       trunkVolume: 1500,
                       isHindcarrigeExist: .set,
                       hindcarrigeFullness: 2000,
                       hindcarriageVolume: 500,
                       description: "")

let semiDescription = teslaTruck.description
print(semiDescription)

teslaTruck.trunkAction(type: .putInTrunk)
teslaTruck.engineAction(type: .start)
teslaTruck.windowsAction(type: .open)


