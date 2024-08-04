//
//  ProgressViewManager.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import UIKit

public class ProgressViewManager {
    static public let shared = ProgressViewManager()
    
    private var progressView: UIActivityIndicatorView!
    private var backgroundView: UIView!
    
    private init() {
        setupProgressView()
    }
    
    private func setupProgressView() {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        backgroundView = UIView(frame: window.bounds)
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        progressView = UIActivityIndicatorView(style: .large)
        progressView.center = backgroundView.center
        progressView.hidesWhenStopped = true
        
        backgroundView.addSubview(progressView)
        window.addSubview(backgroundView)
        
        backgroundView.isHidden = true
    }
    
    public func showProgressView() {
        DispatchQueue.main.async {
            self.backgroundView.isHidden = false
            self.progressView.startAnimating()
        }
    }
    
    public func hideProgressView() {
        DispatchQueue.main.async {
            self.progressView.stopAnimating()
            self.backgroundView.isHidden = true
        }
    }
}

