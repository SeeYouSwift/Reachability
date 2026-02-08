# Reachability

A lightweight Swift package for monitoring network connectivity using Apple's `Network` framework. Provides a simple, thread-safe API to check whether the device is currently online.

## Features

- Real-time network status monitoring via `NWPathMonitor`
- Protocol-based design for easy mocking in tests
- Thread-safe property access using `NSLock`
- Zero configuration — just instantiate and read

## Requirements

- iOS 18+ / macOS 15+
- Swift 6+

## Installation

### Swift Package Manager

**Via Xcode:**
1. File → Add Package Dependencies
2. Enter the repository URL:
   ```
   https://github.com/SeeYouSwift/Reachability
   ```
3. Select version rule and click **Add Package**

**Via `Package.swift`:**

```swift
dependencies: [
    .package(url: "https://github.com/SeeYouSwift/Reachability", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["Reachability"]
    ),
    // For test targets — add the mock library:
    .testTarget(
        name: "YourTargetTests",
        dependencies: [
            "YourTarget",
            .product(name: "ReachabilityMocks", package: "Reachability")
        ]
    )
]
```
## Usage

### Basic

```swift
import Reachability

let reachability = Reachability()

if reachability.isConnected {
    print("Online")
} else {
    print("Offline")
}
```

### Dependency Injection

Use `ReachabilityProtocol` in your services and view models so they are easy to test:

```swift
import Reachability

final class FeedViewModel {
    private let reachability: ReachabilityProtocol

    init(reachability: ReachabilityProtocol = Reachability()) {
        self.reachability = reachability
    }

    func refresh() async {
        guard reachability.isConnected else {
            // show offline banner
            return
        }
        // fetch data
    }
}
```

### Testing

```swift
import ReachabilityMocks

let mock = MockReachability()
mock.isConnected = false

let viewModel = FeedViewModel(reachability: mock)
// test offline behaviour
```

## API Reference

### `ReachabilityProtocol`

```swift
public protocol ReachabilityProtocol {
    var isConnected: Bool { get }
}
```

### `Reachability`

| Member | Description |
|--------|-------------|
| `init()` | Starts monitoring immediately on a `.utility` background queue |
| `isConnected: Bool` | Current network status; thread-safe |

## How It Works

`Reachability` creates an `NWPathMonitor` and starts it on a dedicated serial `DispatchQueue`. Whenever the network path changes the monitor updates an internal `_isConnected` flag protected by `NSLock`. Public access to `isConnected` always acquires the lock, making it safe to call from any thread or actor.

The monitor is automatically cancelled in `deinit`.
