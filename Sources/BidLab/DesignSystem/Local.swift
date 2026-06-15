import SwiftUI

/// A drop-in replacement for `@State`.
///
/// This machine's Command Line Tools ship every SwiftUI macro plugin except
/// `SwiftUIMacros`, so `@State` (now an attached macro) cannot expand when we
/// build with `swiftc` directly. The underlying `State<Value>` struct still
/// exists, so this small `DynamicProperty` wraps it and behaves identically:
/// write `@Local var x = 0` in place of `@State var x = 0`, with `$x` giving a
/// `Binding`. Swap back to `@State` once a full Xcode toolchain is available.
@propertyWrapper
struct Local<Value>: DynamicProperty {
    private var storage: State<Value>

    init(wrappedValue: Value) {
        storage = State(wrappedValue: wrappedValue)
    }

    var wrappedValue: Value {
        get { storage.wrappedValue }
        nonmutating set { storage.wrappedValue = newValue }
    }

    var projectedValue: Binding<Value> {
        storage.projectedValue
    }
}
