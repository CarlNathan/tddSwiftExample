//
//  ViewControllerSpec.swift
//  tddSwiftTests
//
//  Created by Carl Udren on 10/9/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import tddSwift

class ViewControllerSpec: QuickSpec {
    
    class Mock_UISwitch_isOn: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return true
            }
        }
        
    }
    
    class Mock_UISwitch_isOFF: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return false
            }
        }
        
    }
    
    class Spy_MathHelper: MathHelperProtocol {
        var doNoMathWasCalled: Bool = false
        var sumArrayWasCaelled: Bool = false
        let mathHelper: MathHelperProtocol
        
        init(_ mathHelper: MathHelperProtocol) {
            self.mathHelper = mathHelper
        }
        
        func doNoMath() -> String {
            doNoMathWasCalled = true
            return mathHelper.doNoMath()
        }
        
        func sumArray(array: Array<Float>) -> Float {
            sumArrayWasCaelled = true
            return mathHelper.sumArray(array: array)
        }
    }
    
    class Stub_MathHelper: MathHelperProtocol {
        static let arrayReturnFloat: Float = 12.7
        static let noMathReturnString = "No Math Test String"
        
        var doNoMathWasCalled: Bool = false
        var sumArrayWasCaelled: Bool = false
        var sumArrayInput: Array<Float>?
        
        func sumArray(array: Array<Float>) -> Float {
            sumArrayInput = array
            sumArrayWasCaelled = true
            return Stub_MathHelper.arrayReturnFloat
        }
        
        func doNoMath() -> String {
            doNoMathWasCalled = true
            return Stub_MathHelper.noMathReturnString
        }
        
        
    }

    override func spec() {
        describe("A ViewController") {
            var subject: ViewController!
            
            beforeEach {
                let window = UIWindow(frame: UIScreen.main.bounds)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                window.rootViewController = subject
                window.makeKeyAndVisible()
                let _ = subject.view
            }
            
            context("Using a math helper spy", {
                context("When make math happen switch is flipped", {
                    context("When meaning of life switch is off", {
                        beforeEach {
                            let fakeSwitch = Mock_UISwitch_isOn()
                            subject.mathHelper = Spy_MathHelper(subject.mathHelper)
                            subject.mathArray = [15.0, 2.7, 7.1]
                            subject.meaningOfLifeSwitch.setOn(false, animated: false)
                            subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                        }
                        
                        it("should call sum array") {
                            expect((subject.mathHelper as! Spy_MathHelper).sumArrayWasCaelled).to(beTrue())
                        }
                        
                        it("should set result text to array sum") {
                            expect(subject.resultLabel.text).to(equal("24.8"))
                        }
                    })
                    
                    context("When meaning of life switch is on", {
                        beforeEach {
                            let fakeSwitch = Mock_UISwitch_isOn()
                            subject.mathHelper = Spy_MathHelper(subject.mathHelper)
                            subject.mathArray = [15.0, 2.7, 7.1]
                            subject.meaningOfLifeSwitch.setOn(true, animated: false)
                            subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                        }
                        
                        it("should set result text to 42") {
                            expect(subject.resultLabel.text).to(equal("42"))
                        }
                        
                        it("should not call the do no math method") {
                            expect((subject.mathHelper as! Spy_MathHelper).doNoMathWasCalled).to(beFalse())
                        }
                    })
                })
                
                context("When math switch is off", {
                    beforeEach {
                        let fakeSwitch = Mock_UISwitch_isOFF()
                        let mathHelperMock = Spy_MathHelper(subject.mathHelper)
                        subject.mathHelper = mathHelperMock // subject.mathHelper was changed to a var from let, but would prefer init injection
                        subject.mathArray = [15.0, 2.7, 7.1]
                        subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                    }
                    
                    it("should not do math") {
                        expect(subject.resultLabel.text).to(equal("No Math"))
                    }
                    
                    it("should call the do no math method") {
                        expect((subject.mathHelper as! Spy_MathHelper).doNoMathWasCalled).to(beTrue())
                    }
                })
                
            })
            
            context("Using a math helper mock", {
                context("When make math happen switch is flipped", {
                    context("When meaning of life switch is off", {
                        beforeEach {
                            let fakeSwitch = Mock_UISwitch_isOn()
                            subject.mathHelper = Stub_MathHelper()
                            subject.mathArray = [15.0, 2.7, 7.1]
                            subject.meaningOfLifeSwitch.setOn(false, animated: false)
                            subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                        }
                        
                        it("should pass in its math array") {
                            expect((subject.mathHelper as! Stub_MathHelper).sumArrayInput).to(equal(subject.mathArray))
                        }
                        
                        it("should call sum array") {
                            expect((subject.mathHelper as! Stub_MathHelper).sumArrayWasCaelled).to(beTrue())
                        }
                        
                        it("should set result text to array sum") {
                            expect(subject.resultLabel.text).to(equal(String(Stub_MathHelper.arrayReturnFloat)))
                        }
                    })
                    
                    context("When meaning of life switch is on", {
                        beforeEach {
                            let fakeSwitch = Mock_UISwitch_isOn()
                            subject.mathHelper = Stub_MathHelper()
                            subject.mathArray = [15.0, 2.7, 7.1]
                            subject.meaningOfLifeSwitch.setOn(true, animated: false)
                            subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                        }
                        
                        it("should set result text to math helper result") {
                            expect(subject.resultLabel.text).to(equal("42"))
                        }
                        
                        it("should call the sum array method") {
                            expect((subject.mathHelper as! Stub_MathHelper).sumArrayWasCaelled).to(beFalse())
                        }
                    })
                })
                
                context("When math switch is off", {
                    beforeEach {
                        let fakeSwitch = Mock_UISwitch_isOFF()
                        let mathHelperMock = Stub_MathHelper()
                        subject.mathHelper = mathHelperMock // subject.mathHelper was changed to a var from let, but would prefer init injection
                        subject.mathArray = [15.0, 2.7, 7.1]
                        subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                    }
                    
                    it("should not do math") {
                        expect(subject.resultLabel.text).to(equal(Stub_MathHelper.noMathReturnString))
                    }
                    
                    it("should call the do no math method") {
                        expect((subject.mathHelper as! Stub_MathHelper).doNoMathWasCalled).to(beTrue())
                    }
                })
                
            })
            
        }
    }
}
