import Foundation
import Network

/// Concrete implementation of `ReachabilityProtocol` using `NWPathMonitor`.
/// Starts monitoring immediately on init and cancels automatically on deinit.
public final class Reachability: ReachabilityProtocol, @unchecked Sendable {

    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    private let lock = NSLock()
    private var _isConnected: Bool = true

    public var isConnected: Bool {
        lock.withLock { _isConnected }
    }

    public init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "reachability.monitor", qos: .utility)

        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.lock.withLock {
                self._isConnected = path.status == .satisfied
            }
        }

        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
