//
//  MLMultiArrayExtensions.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 21/08/2020.
//

import CoreML

extension MLMultiArray {
    subscript(index: [Int]) -> NSNumber {
        // Subscript is used to retrieve values by index.
        // Set input and return type, in this case the subscript is read only, as no new value is being set.
        return self[index.map { NSNumber(value: $0)}]
    }
}
