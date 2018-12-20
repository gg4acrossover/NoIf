//: [Previous](@previous)

import Foundation

func positive(x: Int) -> Bool {
    return x > 0
}

func lessThan100(x: Int) -> Bool {
    return x < 100
}

do {
    func doFilterAny(_ value: Int) -> Bool {
        // using curry func
        let or = V.anyPass([positive,lessThan100])
        return or(value)
    }

    func doFilterAll(_ value: Int) -> Bool {
        return V.allPass([positive,lessThan100], value: value)
    }

    let arr = [99,100,200,300]
    arr.filter(doFilterAll)
    arr.filter(doFilterAny)
    arr.filter { (value) -> Bool in
        return value > 0
    }
}

do {
    func ifTrue(x: Int) {
        print("show \(x)")
    }

    func ifFailure(x: Int) {
        print("hide \(x)")
    }

    let checkPositive = V.ifElse(condition: positive,
                                 true: ifTrue,
                                 false: ifFailure)
    checkPositive(100)
    checkPositive(-1)
}

