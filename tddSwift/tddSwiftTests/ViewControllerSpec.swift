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
    
    class Stub_UISwitch_isOn: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return true
            }
        }
        
    }
    
    class Stub_UISwitch_isOFF: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return false
            }
        }
        
    }
    
    class Mock_MathHelper: MathHelper {
        var doNoMathWasCalled: Bool  = false
        
        override func doNoMath() -> String {
            doNoMathWasCalled = true
            return super.doNoMath()
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
            
            context("When make math happen switch is flipped", {
                context("When meaning of life switch is off", {
                    beforeEach {
                        let fakeSwitch = Stub_UISwitch_isOn()
                        subject.mathArray = [15.0, 2.7, 7.1]
                        subject.meaningOfLifeSwitch.setOn(false, animated: false)
                        subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                    }
                    
                    it("should set result text to array sum") {
                        expect(subject.resultLabel.text).to(equal("24.8"))
                    }
                })
                
                context("When meaning of life switch is on", {
                    beforeEach {
                        let fakeSwitch = Stub_UISwitch_isOn()
                        let mathHelperMock = Mock_MathHelper()
                        subject.mathHelper = mathHelperMock // subject.mathHelper was changed to a var from let, but would prefer init injection
                        subject.mathArray = [15.0, 2.7, 7.1]
                        subject.meaningOfLifeSwitch.setOn(true, animated: false)
                        subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                    }
                    
                    it("should set result text to 42") {
                        expect(subject.resultLabel.text).to(equal("42"))
                    }
                    
                    it("should not call the do no math method") {
                        expect((subject.mathHelper as! Mock_MathHelper).doNoMathWasCalled).to(beFalse())
                    }
                })
            })
            
            context("When math switch is off", {
                beforeEach {
                    let fakeSwitch = Stub_UISwitch_isOFF()
                    let mathHelperMock = Mock_MathHelper()
                    subject.mathHelper = mathHelperMock // subject.mathHelper was changed to a var from let, but would prefer init injection
                    subject.mathArray = [15.0, 2.7, 7.1]
                    subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                }
                
                it("should not do math") {
                    expect(subject.resultLabel.text).to(equal("No Math"))
                }
                
                it("should call the do no math method") {
                    expect((subject.mathHelper as! Mock_MathHelper).doNoMathWasCalled).to(beTrue())
                }
            })
        }
    }
}
