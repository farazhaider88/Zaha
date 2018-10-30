//
//  Array+Extensions.swift


import Foundation


extension Array {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Int ) -> Element? {
        return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    }
}


