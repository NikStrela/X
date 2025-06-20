import Foundation

/*
 Task #1.1 - Скомпилируется ли код?
 */

class classA {
    class func classFunc() {}
    static func staticFunc() {}
}

class classB: classA {
    override class func classFunc() {}
//    override class func staticFunc() {}             // Ошибка: Cannot override static method
}

/*
 Task #1.2 - Скомпилируется ли код?
 */

class classC {
//    class var classStoredPropertyVariable = "classVariable"                 // Ошибка: не может быть stored property class
    var classComputedPropertyVariable: Int {
        get {
            return 1
        }
    }
    
    @MainActor static var staticStoredPropertyVariable = "staticVariable"
    static var staticComputedPropertyVariable: Int {
        get {
            return 1
            
        }
    }
}

/*
 Task #2.1 - Что выведется?
 */

func task2a() {
    let firstName: NSString = "User Name"
    let secondName: NSString = "User Name"
    
    print(
        firstName === secondName
        ? "равны"
        : "не равны"
    )
}
//task2a()

/*
 Task #2.2 - Что выведется?
 */

func task2b() {
    let firstName: String = "User Name"
    let secondName: String = "User Name"
    
//    print(
//        firstName === secondName
//        ? "равны"
//        : "не равны"
//    )
}
//task2b()

/*
 Task #3 - Что выведется?
 */

final class CustomArray {
    
    var array: [Int] = [] {
        didSet {
            print("didSet: \(array)")
        }
    }
    
    init(_ array: [Int]) {
        self.array = array
    }
    
    deinit {
        print(Thread.isMainThread, Thread.current)
        print("deinit")
        array = [4]
        print(array)
    }
}

func task3() {
    DispatchQueue.global().async {
        var customArray: CustomArray? = CustomArray([1])
        customArray?.array = [2]
        customArray?.array.append(3)
        customArray = nil
    }
}
//task3()

/*
 Task #4 - Что выведется?
 */

func task4() {
    var array = [1,2,3]
    for i in array {
        print(i)
        array = [4,5,6]
    }
    
    print(array)
}
//task4()

/*
 Task #5 - Что выведется?
 */

func task5() {
    class A {
        weak var delegate: B?
    }
    
    class B {
        weak var delegate: A?
    }
    
    weak var a: A?
    weak var b: B?
    
    func configure() {
        a = A()
        b = B()
        
        a?.delegate = b
        b?.delegate = a
    }
    
    configure()
    print(a)
    print(b)
    print(a?.delegate)
    print(b?.delegate)
}
//task5()

/*
 Task #6 - Что выведется?
 */

protocol Car {
    func drive()
}

extension Car {
    func drive() {
        print("car drive")
    }
}

class BMW {
    func drive() {
        print("bmw drive")
    }
}

class AUDI: Car {
    func drive() {
        print("audi drive")
    }
}

let bmw = BMW()
let audi: Car = AUDI()

bmw.drive()
audi.drive()
