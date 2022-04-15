//
//  UIViewController+extension.swift
//  Henri Potier
//
//  Created by Yassine EL HALAOUI on 15/4/2022.
//

import UIKit

extension UIViewController {
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Problem !!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Button", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
