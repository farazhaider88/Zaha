//
//  UtilityExtensions.swift


import Foundation

extension RawRepresentable {
    
    init?(raw: RawValue?) {
        guard let raw = raw else {
            return nil
        }
        self.init(rawValue: raw)
    }
    
    init(raw: RawValue?, defaultValue: Self) {
        guard let value = raw  else {
            self = defaultValue
            return
        }
        self = Self(rawValue: value) ?? defaultValue
    }
}

func iterateEnum<T: Hashable>(from: T.Type) -> AnyIterator<T> {
    var x = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &x) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        defer {
            x += 1
        }
        return next.hashValue == x ? next : nil
    }
}


