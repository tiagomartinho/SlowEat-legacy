// Generated using Sourcery 0.7.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable file_length
// swiftlint:disable vertical_whitespace
// swiftlint:disable trailing_whitespace
fileprivate func compareOptionals<T>(lhs: T?, rhs: T?, compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
switch (lhs, rhs) {
case let (lValue?, rValue?):
return compare(lValue, rValue)
case (nil, nil):
return true
default:
return false
}
}

fileprivate func compareArrays<T>(lhs: [T], rhs: [T], compare: (_ lhs: T, _ rhs: T) -> Bool) -> Bool {
guard lhs.count == rhs.count else { return false }
for (idx, lhsItem) in lhs.enumerated() {
guard compare(lhsItem, rhs[idx]) else { return false }
}

return true
}


// MARK: - AutoEquatable for classes, protocols, structs
// MARK: - Event AutoEquatable
extension Event: Equatable {} 
internal func == (lhs: Event, rhs: Event) -> Bool {
guard lhs.type == rhs.type else { return false }
guard lhs.date == rhs.date else { return false }
return true
}
// MARK: - Meal AutoEquatable
extension Meal: Equatable {} 
internal func == (lhs: Meal, rhs: Meal) -> Bool {
guard lhs.events == rhs.events else { return false }
return true
}

// MARK: - AutoEquatable for Enums

// MARK: -
