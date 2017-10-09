//
//  MathHelperSpec.swift
//  tddSwiftTests
//
//  Created by Carl Udren on 10/9/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import tddSwift


class MathHelperSpec: QuickSpec {
    override func spec() {
        describe("A MathHelper") {
            var subject: MathHelper!
            
            beforeEach {
                subject = MathHelper()
            }
            
            it("should return the sum of all the integers in the array") {
                let testArray: Array<Float> = [2.4, 1.0, 9.6]
                let result = subject.sumArray(array: testArray)
                expect(result).to(equal(13.0))
            }
            
            it ("should return zero if the array is empty") {
                let testArray: Array<Float> = []
                let result = subject.sumArray(array: testArray)
                expect(result).to(equal(0.0))
            }
            
            it("should return a 42 if the array contains a 42 regardless of the sum") {
                let testArray: Array<Float> = [2.4, 42.0, 9.6]
                let result = subject.sumArray(array: testArray)
                expect(result).to(equal(42.0))
            }
        }
    }
}
