import Foundation

public protocol Refinement {
    associatedtype RefinedType
    static func pass(_ value: RefinedType) -> Bool
}

public struct Refined<A,R: Refinement> where A == R.RefinedType {
    public let value: A
    public init?(_ value: A) {
        guard R.pass(value) else { return nil }
        self.value = value
    }
}

extension Refined: Equatable where A: Equatable {
    public static func == (lhs: Refined, rhs: Refined) -> Bool {
        return lhs.value == rhs.value
    }
}

extension Refined: Hashable where A: Hashable {
    public var hashValue: Int {
        return self.value.hashValue
    }
}

public extension Refinement {
    static func of(_ value: RefinedType) -> Refined<RefinedType,Self>? {
        return Refined(value)
    }
}
