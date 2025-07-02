import Foundation

// Task #8 - Будет ли работать следующий код?

// actor Animal {
//    var legs: [String] = ["right", "left"]
//    var hends: [String] = ["right", "left"]
//
//    func getLeftHand() -> String? {
//        hends.first { $0 == "left" }
//    }
//
//    func getRightHand() -> String? {
//        hends.first { $0 == "right" }
//    }
//
//    func getLeftLeg() -> String? {
//        legs.first { $0 == "left" }
//    }
//
//    func getRightLeg() -> String? {
//        legs.first { $0 == "right" }
//    }
// }
//
//
// final actor Dog: Animal {
//    func getLeftHand() -> String? {
//        hends.first { $0 == "right" }
//    }
// }

// Task #9 - Решит ли данный сервис проблему Data Race?

// public enum NetworkError: Error {
//    case wrongModel
//    case unknownURL
// }
//
// class NetworkRouter {
//    var headers: [String: String] = [
//        "device": "mobile",
//        "version": "1.0.0"
//    ]
//
//    func sendRequest(for request: URLRequest) async throws -> String {
//        var request = request
//        request.allHTTPHeaderFields = await headers
//
//        let result = try await URLSession.shared.data(for: request)
//        return String(describing: result.0)
//    }
// }
//
// actor RefreshService {
//    private let networkRouter: NetworkRouter
//
//    init(networkRouter: NetworkRouter) {
//        self.networkRouter = networkRouter
//    }
//
//    func getNewToken(for refreshToken: String) async throws -> String {
//        guard let url = URL(string: "www.apple.com") else { throw NetworkError.unknownURL }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        do {
//            return try await networkRouter.sendRequest(for: request)
//        } catch {
//            throw NetworkError.wrongModel
//        }
//    }
// }

// Task #10 - Правильно ли реализован код?

// enum RepairError: Error {
//    case notRepair
// }
//
// protocol Detail: Sendable {}
//
// struct Door: Detail {
//    let needNew: Bool
//    let needNewColor: Bool
// }
//
// final class CustomBuild {
//    func getWrongDetailCar() async -> Detail {
//        await withUnsafeContinuation { continuation in
//            contact(detail: { detail in
//                continuation.resume(returning: detail)
//            }, fail: { wrongDetail in
//                continuation.resume(returning: wrongDetail)
//            })
//        }
//    }
//
//    private func contact(detail: @escaping (Detail) -> Void, fail: @escaping (Error) -> Void) {
//        fail(RepairError.notRepair)
//    }
// }

// Решение

// enum RepairError: Error {
//    case notRepair
// }
//
// protocol Detail: Sendable {}
//
// struct Door: Detail {
//    let needNew: Bool
//    let needNewColor: Bool
// }
//
// final class CustomBuild {
//    func getWrongDetailCar() async throws -> Detail {
//        try await withCheckedThrowingContinuation { [weak self] continuation in
//            self?.contact(detail: { detail in
//                continuation.resume(returning: detail)
//            }, fail: { wrongDetail in
//                continuation.resume(throwing: wrongDetail)
//            })
//        }
//    }
//
//    private func contact(detail: @escaping (Detail) -> Void, fail: @escaping (Error) -> Void) {
//        fail(RepairError.notRepair)
//    }
// }
//

//Task {
//    do {
//        let build = CustomBuild()
//        let detail = try await build.getWrongDetailCar()
//        print(detail)
//    } catch {
//        print("error \(error)")
//    }
//}

// Task #11 - Что выведет код?

// class  Counter {
//    private  var value =  0
//
//    func  increment () {
//        value +=  1
//     }
//
//    func  getValue () -> Int {
//        return value
//    }
// }
//
//
// let counter =  Counter ()
// DispatchQueue.concurrentPerform(iterations: 1000 ) { _  in
//     counter.increment()
// }
//
// print (counter.getValue())

// class  Counter {
//    private  var value =  0
//    let queue = DispatchQueue(label: "concurrent", attributes: .concurrent)
//
//    func  increment () {
//        queue.async(flags: .barrier) {
//            self.value +=  1
//        }
//     }
//
//    func  getValue () -> Int {
//        queue.sync {
//            return value
//        }
//    }
// }
//
// let dispatchGroup = DispatchGroup()
//
// let counter =  Counter ()
// for _ in 1...1000 {
//    DispatchQueue.global().async {
//        dispatchGroup.enter()
//        counter.increment()
//        dispatchGroup.leave()
//    }
// }

//dispatchGroup.wait()
//    print(counter.getValue())
//}

// 2 вариант задачи

// class  Counter {
//   private  var value =  0
//
//   func increment () async {
//       value +=  1
//    }
//
//   func  getValue () -> Int {
//       return value
//   }
// }
//
// let counter = Counter()
// Task {
//    await withTaskGroup(of: Void.self) { group in
//        for _ in 1...1000 {
//            group.addTask {
//                await counter.increment()
//            }
//        }
//    }
//    print(await counter.getValue())
// }

