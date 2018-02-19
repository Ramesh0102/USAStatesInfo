//
//  CustomStateInfoTableViewCell.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import UIKit

/**
 * Error Alerts based on the message passed
 */
extension UIViewController{
    
    func showAlert(message:String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Warning!", comment: "Warning title"), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK title"), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}


