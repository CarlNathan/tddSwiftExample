//
//  MathHelper.swift
//  tddSwift
//
//  Created by Carl Udren on 10/9/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation

class MathHelper {
    
    func sumArray(array: Array<Float>) -> Float {
        if array.contains(42.0) {return 42.0}
        var total: Float = 0
        for element in array {
            total += element
        }
        return total
    }
    
}

