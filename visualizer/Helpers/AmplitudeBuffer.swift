//
//  AmplitudeBuffer.swift
//  visualizer
//
//  Created by Mark Cheng on 16/4/2022.
//

import Foundation

public struct AmplitudeBuffer<T> {
    private var array: [T?]
    private var index = 0

    var count: Int {
        return self.array.count
    }
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }

    public mutating func clear() {
        forceToValue(nil)
    }

    public mutating func forceToValue(_ value: T?) {
        let count = array.count
        array = [T?](repeating: value, count: count)
    }

    public mutating func write(_ element: T) {
        array[index % array.count] = element
        index += 1
    }
    
    public func values() -> [T] {
        var result = [T?]()
        for loop in 0..<array.count {
            result.append(array[(loop+index) % array.count])
        }
        return result.compactMap { $0 }
    }
}
