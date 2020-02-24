//
//  RoundedView.swift
//  News
//
//  Created by Tran Duy Linh on 2/24/20.
//  Copyright © 2020 Duy Linh Tran. All rights reserved.
//

import UIKit
// swiftlint:disable all

@IBDesignable
class RoundedView: UIView, Roundable {
    var cornerRadius: CGFloat = 0.0
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
            setupLayer()
        }
    }

    @IBInspectable var cornerRadius_: CGFloat = 0 {
        didSet {
            setupLayer()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            setupLayer()
        }
    }

    @IBInspectable var borderColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) {
        didSet {
            setupLayer()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }
}

protocol Roundable {
    var isCircle: Bool { get set }
    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
}

extension Roundable where Self: UIView {
    func setupLayer() {
        clipsToBounds = true

        if isCircle {
            layer.cornerRadius = frame.width < frame.height ? frame.width / 2 : frame.height / 2
        } else {
            layer.cornerRadius = cornerRadius
        }

        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
