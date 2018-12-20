import UIKit

// refer to: https://github.com/peter-tomaselli/swift-refined
// Validator enum
enum OneOf<R1: Refinement, R2: Refinement>: Refinement where R1.RefinedType == R2.RefinedType {
    public typealias RefinedType = R1.RefinedType
    
    static func pass(_ value: RefinedType) -> Bool {
        return R1.pass(value) || R2.pass(value)
    }
}

enum Both<R1: Refinement, R2: Refinement>: Refinement where R1.RefinedType == R2.RefinedType {
    public typealias RefinedType = R1.RefinedType
    
    static func pass(_ value: RefinedType) -> Bool {
        return R1.pass(value) && R2.pass(value)
    }
}

// first case
enum Positive<T: Numeric & Comparable>: Refinement {
    static func pass(_ value: T) -> Bool {
        return value > 0
    }
}

enum LessThan100<T: Numeric & Comparable>: Refinement {
    static func pass(_ value: T) -> Bool {
        return value < 100
    }
}

Positive<Double>.of(100.0)?.value
Positive<Int>.of(-1)?.value
Both<Positive<Float>,LessThan100<Float>>.of(99)?.value
Both<Positive<Float>,LessThan100<Float>>.of(101)?.value

// second case
struct Person: CustomStringConvertible {
    let firstName: String
    let lastName: String
    
    public var description: String {
        return "Person: \(self.firstName)\(self.lastName)"
    }
}

enum PersonValid: Refinement {
    static func pass(_ p: Person) -> Bool {
        return !p.firstName.isEmpty && !p.lastName.isEmpty
    }
}

PersonValid.of(
    Person(firstName: "", lastName: "over")
)?.value

PersonValid.of(
    Person(firstName: "cross", lastName: "over")
)?.value

