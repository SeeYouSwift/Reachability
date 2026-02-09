import Testing
import Foundation
@testable import Reachability

struct ReachabilityTests {

    @Test func initialStateIsConnected() {
        let sut = Reachability()
        // NWPathMonitor reports `.satisfied` by default on device/simulator
        #expect(sut.isConnected == true)
    }

    @Test func protocolConformance() {
        let sut: any ReachabilityProtocol = Reachability()
        // Verify that `isConnected` is accessible through the protocol
        _ = sut.isConnected
    }
}
