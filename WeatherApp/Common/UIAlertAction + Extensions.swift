//
//  UIAlertAction + Extensions.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import UIKit

extension UIAlertAction {

    static func createAddAction(textField: UITextField?, viewModel: CitiesViewModel, completion: @escaping () -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Add", style: .default) { _ in
            if let name = textField?.text?.capitalized, !name.isEmpty {
                if viewModel.isCityAlreadyAdded(name: name) {
                    let existsAlert = UIAlertController(title: "City Already Exists", message: "The city \(name) is already added.", preferredStyle: .alert)
                    existsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = getRootViewController() {
                        rootViewController.present(existsAlert, animated: true, completion: nil)
                    }
                } else {
                    viewModel.addCity(name: name)
                    completion()
                }
            }
        }
    }

    private static func getRootViewController() -> UIViewController? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            return rootViewController
        }
        return nil
    }

    static func createCancelAction() -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
}
