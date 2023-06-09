//
//  test_2Tests.swift
//  test 2Tests
//
//  Created by Flore Gridaine on 2023-03-13.
//

import XCTest
@testable import Calculette

final class calculsTests: XCTestCase {
    //MARK: - Properties
    var calculs: Calculs!
    
    override func setUp() {
        super.setUp()
        calculs =  Calculs()
    }

    //MARK: - Test Methods
    func testCalculsClassExist() {
        XCTAssertNotNil(calculs)
    }
    
    func testGiven1IsTapped_WhenPlus2IsTapped_ThenResultsIsThree() {
        let one = 1
        let plus = "+"
        let two = 2
        let result = calculs.calculate(left: one, operand: plus, right: two)
        XCTAssertEqual(result, 3)
    }
    
    func testGiven4IsTapped_WhenMinus2IsTapped_ThenResultsIs2() {
        let four = 4
        let minus = "-"
        let two = 2
        let result = calculs.calculate(left: four, operand: minus, right: two)
        XCTAssertEqual(result, 2)
    }
    
    func testGiven4IsTapped_WhenDivided2IsTapped_ThenResultsIs2() {
        let four = 4
        let divide = "/"
        let two = 2
        let result = calculs.calculate(left: four, operand: divide, right: two)
        XCTAssertEqual(result, 2)
    }
    
    func testGiven4IsTapped_WhenMultiply2IsTapped_ThenResultsIs8() {
        let four = 4
        let multiply = "x"
        let two = 2
        let result = calculs.calculate(left: four, operand: multiply, right: two)
        XCTAssertEqual(result, 8)
    }
    
    func testGiven2Plus5_WhenMultiplyBy2_thenResultIs12() {
        let elements = ["2","+","5","x","2"]
        let result = calculs.resolve(elements: elements)
        XCTAssertEqual(result, "12")
    }
    
    func testGiven10Minus6_WhenDivideBy2_thenResultIs7() {
        let elements = ["10","-","6","/","2"]
        let result = calculs.resolve(elements: elements)
        XCTAssertEqual(result, "7")
    }
    
    func testGivenLeftOperandIs2AndRightOperandIs7_WhenOperatorIsX_ThenResultIsTrue() {
           // Test with operations containing multiplication
        let elements = ["+", "-", "x", "/"]
           XCTAssertTrue(calculs.checkOperator(elements: elements))
           
           // Test with operations containing division
                    let elements2 = ["+", "-", "/", "+"]
           XCTAssertTrue(calculs.checkOperator(elements: elements2))
           
           // Test with no multiplication or division
                         let elements3 = ["+", "-", "+"]
           XCTAssertFalse(calculs.checkOperator(elements: elements3))
    }
    
    func testGivenMultipleOperation_WhenOneOPeratorIsX_ThenMultiplicationIsPriority() {
        let elements = ["5", "x", "2", "+", "6", "/", "3"]
        let result = calculs.resolve(elements: elements)
        XCTAssertEqual(result, "12")
    }

}
