//
//  Ext+UIViewController.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 15.03.2023.
//

import Foundation

import UIKit

extension UIViewController {
    func makeAlert(view: UIViewController, error: Error) {
        let dialogMessage = UIAlertController(title: "Hata", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default)
        dialogMessage.addAction(ok)
        view.present(dialogMessage, animated: true, completion: nil)
    }
    func makeInfoAlert(view: UIViewController, info: String, title: String) {
        let dialogMessage = UIAlertController(title: title, message: info, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Tamam", style: .default)
        dialogMessage.addAction(ok)
        view.present(dialogMessage, animated: true, completion: nil)
    }
}
