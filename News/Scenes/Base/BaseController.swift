//
//  BaseController.swift
//  News
//
//  Created by Duy Linh Tran on 2/23/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
// swiftlint:disable all

class BaseController: UIViewController {
    
    // MARK: - Vars
    let spinner = UIActivityIndicatorView(style: .gray)
    let spinnerView = UIView()
    
    var rightBarImage: String? {
        didSet {
            if let name = self.rightBarImage {
                if let resourceImage = UIImage(named: name) {
                    let button = UIButton(type: .custom)
                    button.setImage(resourceImage, for: .normal)
                    button.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
                    button.addTarget(self, action: #selector(rightMenuAction), for: .touchUpInside)
                    let barButton = UIBarButtonItem(customView: button)
                    self.navigationItem.rightBarButtonItem = barButton
                }
            }
        }
    }
    
    var backBarImage: String? {
        didSet {
            if let name = self.backBarImage {
                if let resourceImage = UIImage(named: name) {
                    let button = UIButton(type: .custom)
                    button.setImage(resourceImage, for: .normal)
                    button.frame = CGRect(x: 0, y: 0, width: 40, height: 44)
                    button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
                    let barButton = UIBarButtonItem(customView: button)
                    self.navigationItem.leftBarButtonItem = barButton
                }
            }
        }
    }
    
    var leftBarTitle: String? {
        didSet {
            if let name = self.leftBarTitle {
                let textColor = UIColor.black
                let button = UIButton(type: .custom)
                button.setTitle(name, for: .normal)
                button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
                button.contentHorizontalAlignment = .left
                button.titleLabel?.textColor = textColor
                button.setTitleColor(textColor, for: .normal)
                button.addTarget(self, action: #selector(leftMenuAction), for: .touchUpInside)
                let barButton = UIBarButtonItem(customView: button)
                self.navigationItem.leftBarButtonItem = barButton
            }
        }
    }
    
    var rightBarTitle: String? {
        didSet {
            if let name = self.rightBarTitle {
                let textColor = UIColor.black
                let button = UIButton(type: .custom)
                button.setTitle(name, for: .normal)
                button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
                button.contentHorizontalAlignment = .right
                button.titleLabel?.textColor = textColor
                button.setTitleColor(textColor, for: .normal)
                button.addTarget(self, action: #selector(rightMenuAction), for: .touchUpInside)
                let barButton = UIBarButtonItem(customView: button)
                self.navigationItem.rightBarButtonItem = barButton
            }
        }
    }
    
    private var keyboardWillShowObserver: NSObjectProtocol?
    private var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: - Overrides
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
    
    // MARK: - Internal
    func keyboardWillShow(keyboardHeight: CGFloat) {}
    func keyboardWillHide(keyboardHeight: CGFloat) {}
    
    func displayLoading() {
        view.bringSubviewToFront(spinnerView)
        spinnerView.bringSubviewToFront(spinner)
        spinnerView.isHidden = false
        spinner.startAnimating()
    }
    
    func hideLoading() {
        spinnerView.isHidden = true
        spinner.stopAnimating()
    }
    
    // MARK: - Private
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
    
    // MARK: - Actions
    @objc func rightMenuAction() {}
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func leftMenuAction() {}

}
