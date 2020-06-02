import Foundation

final public class ComponentsHub {

    public static let shared = ComponentsHub()

    private init() {

    }

    var protocolClosures = [String : () -> Any]()

}

extension ComponentsHub {

    @discardableResult
    public func register<T>(protocol: T.Type, _ instanceClosure: @escaping () -> T) -> Bool {

        let key = "\(`protocol`)"

        // TODO: add main thread check
        // TODO: Need lock
        protocolClosures[key] = instanceClosure

        return true
    }

    @discardableResult
    public func unRegister<T>(protocol: T.Type) -> Bool {

        let key = "\(`protocol`)"

        guard let _ = protocolClosures[key] else {
            return true
        }

        // TODO: add main thread check
        // TODO: Need lock
        protocolClosures[key] = nil
        return true
    }
}
