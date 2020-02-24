//
//  BaseController.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    // MARK: Internal Properties
    
    let spinner = UIActivityIndicatorView(style: .gray)
    let spinnerView = UIView()
    
    // MARK: Private Properties
    
    private var keyboardWillShowObserver: NSObjectProtocol?
    private var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSpinnerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Internal Helpers
    
    func keyboardWillShow(keyboardHeight: CGFloat) {}
    func keyboardWillHide(keyboardHeight: CGFloat) {}
    
    func displayLoading() {
        view.bringSubviewToFront(spinnerView)
        spinnerView.bringSubviewToFront(spinner)
        spinnerView.isHidden = false
        spinner.startAnimating()
    }
    
    func displayContent() {
        spinnerView.isHidden = true
        spinner.stopAnimating()
    }
    
    // MARK: Private Helpers
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupSpinnerView() {
        spinnerView.addSubview(spinner)
        view.addSubview(spinnerView)
        spinner.hidesWhenStopped = true
        spinnerView.backgroundColor = UIColor.clear
        spinnerView.isHidden = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        let spinnerViewConstraints = [
            spinnerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(spinnerViewConstraints)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        let spinnerConstraints = [
            spinner.centerXAnchor.constraint(equalTo: spinnerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: spinnerView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(spinnerConstraints)
    }
}
