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
    
    class MockUISwitch_ON: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return true
            }
        }
        
    }
    
    class MockUISwitch_OFF: UISwitch {
        override var isOn: Bool {
            set {
                
            }
            get {
                return false
            }
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
                        let fakeSwitch = MockUISwitch_ON()
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
                        let fakeSwitch = MockUISwitch_ON()
                        subject.mathArray = [15.0, 2.7, 7.1]
                        subject.meaningOfLifeSwitch.setOn(true, animated: false)
                        subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                    }
                    
                    it("should set result text to 42") {
                        expect(subject.resultLabel.text).to(equal("42"))
                    }
                })
            })
            
            context("When math switch is off", {
                beforeEach {
                    let fakeSwitch = MockUISwitch_OFF()
                    subject.mathArray = [15.0, 2.7, 7.1]
                    subject.makeMathHappenSwitchChangedValue(fakeSwitch)
                }
                
                it("should not do math") {
                    expect(subject.resultLabel.text).to(equal("No Math"))
                }
            })
        }
    }
}
