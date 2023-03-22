//
//  Calculs.swift
//  test 2
//
//  Created by Flore Gridaine on 2023-03-13.
//

import Foundation
import UIKit

public class Calculs {
    
    func resolve(elements: [String]) -> String { //Le but de la fonction est reduire le nombre dans le tableau elements en les operant entre eux jusqu'a ce qu'il ne reste qu'un nombre qui sera la resultat de l'operation.
        var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            //   if operationsToReduce.contains("x") || operationsToReduce.contains("/") { //condition si operand = x ou /, le calcul est prioritaire sur les operand + et -
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "/" } ){
                let result = self.operatePriorityCalculs(operationsToReduce: operationsToReduce, index: index)
                operationsToReduce[index-1...index+1] = [String(result)]
            } else { // s'il n'y a plus de x ou de / , on effectues les addition et les soustractiosn dans l'ordre du tableau
                let result = self.operateNonPriorityCalculs(operationsToReduce: operationsToReduce , index: 0)
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            }
        }
        return operationsToReduce[0]
    }
    
    func operateNonPriorityCalculs(operationsToReduce: [String], index: Int) -> Int {
        let operationsToReduce = operationsToReduce
        guard let left = Int(operationsToReduce[index]) else { return 0 }
        let operand = operationsToReduce[index + 1 ]
        guard let right = Int(operationsToReduce[index + 2]) else { return 0 }
        let result = self.calculate(left: left, operand: operand, right: right)
        //    operationsToReduce = self.updateElements(elements: operationsToReduce, result: result)
        return result
    }
    
    func reduce(index: Int, result: Int, elements: [String]) -> [String] {
        var operationsToReduce = elements
        operationsToReduce.remove(at: index + 1)
        operationsToReduce[index] = String(result)
        operationsToReduce.remove(at: index - 1)
        return operationsToReduce
    }
    
    func operatePriorityCalculs(operationsToReduce: [String], index: Int) -> Int {
        // Récupérer les nombres à gauche et à droite de l'opérateur
        let left = Int(operationsToReduce[index - 1])!  // si x ou /  = index, alors le nombre a gauche = index - 1
        let operand = operationsToReduce[index]
        let right = Int(operationsToReduce[index + 1])! // si x ou / = index, alors le nombre a droite = index + 1
        let result = self.calculate(left: left, operand: operand, right: right)
        return result
    }
    
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
