//
//  DialogHelper.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-18.
//

import UIKit

extension UIViewController {
    func showConfirmationDialog(title: String,  message: String,  completionHandler: @escaping (Bool)->()) {
           let alert = UIAlertController(
               title: title, message: message, preferredStyle: .alert)
           
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
               completionHandler(false)
           }))
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               completionHandler(true)
           }))

           present(alert, animated: true)
       }
}
