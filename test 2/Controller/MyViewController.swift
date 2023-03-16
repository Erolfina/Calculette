//
//  ViewController.swift
//  test 2
//
//  Created by Flore Gridaine on 2023-03-13.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculs = Calculs()
    
    //affiche ce que l'on ecrit sur le textview. Fonctionne comme un label
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    //verifie que les bouton appuyés sont des chiffres
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    //verifie qu'il y a au moins trois elements pour faire un calcul
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    //verifie que l'on ajoute pas plusieurs operateur les uns apres les autres
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        if expressionHaveResult ||  textView.text == "0" {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        if canAddOperator {
            textView.text.append(" x ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: Any) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        presentAlert()
        let result = calculs.resolve(elements:elements)
            textView.text.append(" = \(result)")
        
    }
    
   func presentAlert() {
        
        let messageWhenExpressionIscorrect = "Entrez une expression correcte !"
        let messageWhenexpressionHaveEnoughElement = "Démarrez un nouveau calcul !"
        let title = "Zéro!"
        
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: title, message: messageWhenExpressionIscorrect, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: title, message: messageWhenexpressionHaveEnoughElement, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
}


