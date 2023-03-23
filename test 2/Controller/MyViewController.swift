//
//  ViewController.swift
//  test 2
//
//  Created by Flore Gridaine on 2023-03-13.
//

import UIKit

class MyViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    //MARK: - Properties
    
    var calculs = Calculs()
    
    //affiche ce que l'on ecrit sur le textview. Fonctionne comme un label
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    //verifie que les bouton appuyés sont des chiffres
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x" && elements.last != "="
    }
    
    //verifie qu'il y a au moins trois elements pour faire un calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    //verifie que l'on ajoute pas plusieurs operateur les uns apres les autres
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "x" && elements.last != "="
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    let presentAlert = PresentAlert()
    let titleAlert = "Ok", titleAction = "Zéro!", message = "Un operateur est déja mis !"
    
    //MARK: - View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        if expressionHaveResult ||  textView.text == "0" {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else { return }
        switch operatorText {
        case "+", "-","/", "x"   :
            if canAddOperator {
                textView.text.append(operatorText)
            } else {
                presentAlert.presentAlert(on: self, titleAlert: titleAlert, titleAction: titleAction, message: message)
            }
        default: break
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        let messageWhenExpressionIscorrect = "Entrez une expression correcte !"
        let messageWhenexpressionHaveEnoughElement = "Démarrez un nouveau calcul !"
        
        guard expressionIsCorrect else {
            presentAlert.presentAlert(on: self, titleAlert: titleAlert, titleAction: titleAlert, message: messageWhenExpressionIscorrect)
            return
        }
        guard expressionHaveEnoughElement else {
            presentAlert.presentAlert(on: self, titleAlert: titleAlert, titleAction: titleAlert, message: messageWhenexpressionHaveEnoughElement)
            return
        }
        let result = calculs.resolve(elements:elements)
        textView.text.append(" = \(result)")
    }

    @IBAction func tappedClearButton(_ sender: Any) {
        textView.text = "0"
    }
}
