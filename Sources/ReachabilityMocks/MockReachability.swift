import Foundation
import Reachability

/// Mock for testing. Set `isConnected` manually to simulate online/offline states.
public final class MockReachability: ReachabilityProtocol, @unchecked Sendable {
    public var isConnected: Bool

    public init(isConnected: Bool = true) {
        self.isConnected = isConnected
    }
}
