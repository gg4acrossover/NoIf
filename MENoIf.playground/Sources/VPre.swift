import Foundation

public class V {}

extension V {
    public class func bind<A,B>(value: A, to: @escaping (A) -> B) -> () -> B {
        return {
            to(value)
        }
    }
    
    public class func allPass<A>(_ array: [(A) -> Bool], value: A) -> Bool {
        let predicate = array.map({ V.bind(value: value, to: $0) })
        return checkAll(predicate)
    }
    
    public class func allPass<A>(_ array: [(A) -> Bool]) -> (A) -> Bool {
        return { v in
            let predicate = array.map({ V.bind(value: v, to: $0) })
            return checkAll(predicate)
        }
    }
    
    public class func anyPass<A>(_ array: [(A) -> Bool]) -> (A) -> Bool {
        return { v in
            let predicate = array.map({ V.bind(value: v, to: $0) })
            return checkAny(predicate)
        }
    }
    
    public class func anyPass<A>(_ array: [(A) -> Bool], value: A) -> Bool {
        let predicate = array.map({ V.bind(value: value, to: $0) })
        return checkAny(predicate)
    }
    
    public class func both<A>(_ lhs: @escaping (A) -> Bool, _ rhs: @escaping (A) -> Bool) -> (A) -> Bool {
        return {
            lhs($0) && rhs($0)
        }
    }
    
    public class func or<A>(_ lhs: @escaping (A) -> Bool, _ rhs: @escaping (A) -> Bool) -> (A) -> Bool {
        return {
            lhs($0) || rhs($0)
        }
    }
    
    public class func ifElse<A,B>(   condition: @escaping (A) -> Bool,
                                     true: @escaping (A) -> B,
                                     false: @escaping (A) -> B)
        -> (A) -> B
    {
        return { a in
            if condition(a) {
                return `true`(a)
            }
            
            return `false`(a)
        }
    }
    
    private class func checkAll(_ conditions: [() -> Bool]) -> Bool {
        for condition in conditions {
            if !condition() {
                return false
            }
        }
        
        return true
    }
    
    private class func checkAny(_ conditions: [() -> Bool]) -> Bool {
        for condition in conditions {
            if condition() {
                return true
            }
        }
        
        return false
    }
}
