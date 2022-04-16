//
//  AmplitudeBuffer.swift
//  visualizer
//
//  Created by Mark Cheng on 16/4/2022.
//

import Foundation

public struct AmplitudeBuffer<T> {
    private var array: [Double]
    private var index = 0

    var count: Int {
        return self.array.count
    }
    
    public init(count: Int) {
        array = [Double](repeating: 0.0, count: count)
    }

    public mutating func resize(_ count: Int){
        array = [Double](repeating: 0.0, count: count)
    }
    
    public mutating func clear() {
        forceToValue(0.0)
    }

    public mutating func forceToValue(_ value: Double) {
        let count = array.count
        array = [Double](repeating: value, count: count)
    }

    public mutating func write(_ element: Double) {
        array[index % array.count] = element
        index += 1
    }
    
    public func values() -> [Double] {
        var result = [Double]()
        for loop in 0..<array.count {
            result.append(array[(loop+index) % array.count])
        }
        return result.compactMap { $0 }
    }
}
