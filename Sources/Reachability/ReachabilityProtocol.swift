import Foundation

/// Protocol for checking network availability.
/// Consumers call `isConnected` before making network requests.
public protocol ReachabilityProtocol: Sendable {
    /// `true` when the device has an active network connection.
    var isConnected: Bool { get }
}
