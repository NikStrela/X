import Foundation

/*
 Task #8.1 - Что выведется?
 
 Вывод программы:
 1
 9
 2
 8
 3
 4
 deadlock
 */

func task8a() {
    print("1")
    
    DispatchQueue.global().async {
        print("2")
        
        DispatchQueue.main.async {
            print("3")
            
            DispatchQueue.global().async {
                print("4")
                
                DispatchQueue.main.sync {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

/*
 Task #8.2 - Что выведется?
 
 Вывод программы:
 1
 9
 2
 8
 3
 4
 6
 7
 5
 */

func task8b() {
    print("1")
    
    DispatchQueue.global().async {
        print("2")
        
        DispatchQueue.main.async {
            print("3")
            
            DispatchQueue.global().sync {
                print("4")
                
                DispatchQueue.main.async {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}
