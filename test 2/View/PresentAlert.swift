//
//  PresentAlert.swift
//  Calculette
//
//  Created by Flore Gridaine on 2023-03-13.
//

import Foundation
import UIKit

public class PresentAlert {
    
    func presentAlert(on vc: UIViewController, titleAlert: String, titleAction: String, message: String) {
        let alertVC = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: titleAction, style: .cancel, handler: nil))
        return vc.present(alertVC, animated: true, completion: nil)
    }
}
