import Foundation

public struct ComponentsHub {

    public static var shared = ComponentsHub()

    private init() {

    }

    private var instancesClosures = [String : () -> Any]()

    private var singletons = [String : Any]()

}

extension ComponentsHub {

    @discardableResult
    public mutating func register<T>(protocol: T.Type, singleton: Bool = false, _ instanceClosure: @escaping () -> T) -> Bool {

        let key = "\(`protocol`)"

        // TODO: add main thread check
        // TODO: Need lock

        if checkExsit(key: key) {
            print("ComponentsHub - register protocol \(key) aleady exsits!")
            return false
        }

        if singleton {
            singletons[key] = instanceClosure()
        } else {
            instancesClosures[key] = instanceClosure
        }
        return true
    }

    @discardableResult
    public mutating func unregister<T>(protocol: T.Type) -> Bool {

        let key = "\(`protocol`)"

        // TODO: add main thread check
        // TODO: Need lock

        if let _ = singletons[key] {
            singletons[key] = nil
            return true
        }
        if let _ = instancesClosures[key] {
            instancesClosures[key] = nil
            return true
        }

        print("ComponentsHub - unregister the protocol \(key) not exsit.")
        return false
    }

    public func get<T>(protocol: T.Type) -> T? {
        let key = "\(`protocol`)"

        if let obj = singletons[key] {
            return obj as? T
        }
        if let closure = instancesClosures[key] {
            return closure() as? T
        }

        print("ComponentsHub - get the protocol \(key) not exsit.")
        return nil
    }

}

extension ComponentsHub {
    func checkExsit(key: String) -> Bool {
        if let _ = singletons[key],
            let _ = instancesClosures[key] {
            return true
        }
        return false
    }
}
