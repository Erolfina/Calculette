//
//  Calculs.swift
//  test 2
//
//  Created by Flore Gridaine on 2023-03-13.
//

import Foundation
import UIKit

///Class that implements all the calculations made by the calculator.
public class Calculs {

    /// Reduces the array of elements by performing arithmetic operations until there is only one element left.
    /// - Parameter elements:An array of strings representing the mathematical expression to be evaluated.
    /// - Returns: A string containing the result of the calculation.
    func resolve(elements: [String]) -> String {
        var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            if checkOperator(elements: operationsToReduce) {
                guard let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "/" }) else { return "" }
                let result = self.operatePriorityCalculs(index: index, elements: operationsToReduce)
                operationsToReduce[index-1...index+1] = [String(result)]
            } else {
                let result = self.operateNonPriorityCalculs(index: 0, elements: operationsToReduce)
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
        }
        return operationsToReduce[0]
    }
    
    /// Check if the current list of operations contains a multiplication or division operator. If so, the calculation of the result of that operator has priority over addition and subtraction.
    /// - Returns: `true` if a multiplication or division operator is found, `false` otherwise.
    func checkOperator(elements: [String]) -> Bool {
        return elements.contains("x") || elements.contains("/")
    }
    
    ///  Performs arithmetic operations for addition and subtraction.
    /// - Parameters:
    ///   - index: n index that represents the location of the operand.
    /// - Returns: An integer representing the result of the arithmetic operation.
    func operateNonPriorityCalculs(index: Int, elements: [String]) -> Int {
        let operationsToReduce = elements
        if operationsToReduce.count <= index + 2 {
                return 0 // or you can return an error message
            }
            guard let left = Int(operationsToReduce[index]) else { return 0 }
            let operand = operationsToReduce[index + 1 ]
            guard let right = Int(operationsToReduce[index + 2]) else { return 0 }
            let result = self.calculate(left: left, operand: operand, right: right)
            return result
    }

    ///  Performs arithmetic operations for multiplication and division.
    /// - Parameters:
    ///   - index:  index that represents the location of the operand.
    /// - Returns: An integer representing the result of the arithmetic operation.
    func operatePriorityCalculs(index: Int, elements: [String]) -> Int {
        // Récupérer les nombres à gauche et à droite de l'opérateur
        let left = Int(elements[index - 1])!
            let operand = elements[index]
            let right = Int(elements[index + 1])!
            let result = self.calculate(left: left, operand: operand, right: right)
            return result
    }
    
    /// Evaluates the expression and performs the appropriate arithmetic operation depending of the operand
    /// - Parameters:
    ///   - left: An integer representing the left operand.
    ///   - operand: A string representing the arithmetic operator
    ///   - right: An integer representing tthe right operand.
    /// - Returns: An integer representing the result of the arithmetic operation.
    func calculate(left: Int, operand: String, right: Int) -> Int {
        
     switch operand {
        case "+": return left + right
        case "-": return left - right
        case "/": return left / right
        case "x": return left * right
        case "=": return right
        default: fatalError("Unknown operator !")
        }
    }
}
