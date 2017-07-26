//
//  GradientView.swift
//  testTile
//
//  Created by Mathieu Vandeginste on 06/12/2016.
//  Copyright © 2016 Mathieu Vandeginste. All rights reserved.
//

import UIKit

class GradientView: UIView {

    var topColor: UIColor = UIColor.white {
        didSet {
            setNeedsLayout()
        }
    }

    var bottomColor: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }

    var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsLayout()
        }
    }

    var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }

    var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }

    var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var startPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var endPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var endPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        layer.shadowRadius = shadowBlur
        layer.shadowOpacity = 1
    }
}
