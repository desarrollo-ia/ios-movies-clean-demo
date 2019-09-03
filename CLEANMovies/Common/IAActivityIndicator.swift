//
//  IAActivityIndicator.swift
//  IAPruebaCartelera
//
//  Created by Eduardo Pacheco on 12/10/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

final class IAActivityIndicator: UIView {

    // MARK: - Properties
    static var DEFAULT_COLOR = UIColor(red: 26.0 / 255.0, green: 84.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
    static var DEFAULT_TEXT_COLOR = UIColor.white
    static var DEFAULT_PADDING: CGFloat = 0

    internal var color: UIColor = IAActivityIndicator.DEFAULT_COLOR
    internal var padding: CGFloat = IAActivityIndicator.DEFAULT_PADDING
    private(set) public var isAnimating: Bool = false
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height)
    }

    // MARK: - Init
    public init(frame: CGRect, color: UIColor? = nil, padding: CGFloat? = nil) {
        self.color = color ?? IAActivityIndicator.DEFAULT_COLOR
        self.padding = padding ?? IAActivityIndicator.DEFAULT_PADDING
        super.init(frame: frame)
        isHidden = true
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        isHidden = true
    }

    // MARK: - Public Methods
    final func startAnimating() {
        isHidden = false
        isAnimating = true
        layer.speed = 1
        setUpAnimation()
    }

    final func stopAnimating() {
        isHidden = true
        isAnimating = false
        layer.sublayers?.removeAll()
    }

    // MARK: - Private Methods
    private final func setUpAnimation() {
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        var animationRect = frame.inset(by: insets)
        let minEdge = min(animationRect.width, animationRect.height)

        layer.sublayers = nil
        animationRect.size = CGSize(width: minEdge, height: minEdge)
        let animSize = animationRect.size
        let circleSpacing: CGFloat = 2
        let circleSize: CGFloat = (animSize.width - 2 * circleSpacing) / 3
        let x: CGFloat = (layer.bounds.size.width - animSize.width) / 2
        let y: CGFloat = (layer.bounds.size.height - circleSize) / 2
        let duration: CFTimeInterval = 0.75
        let beginTime = CACurrentMediaTime()
        let beginTimes: [CFTimeInterval] = [0.12, 0.24, 0.36]
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.68, 0.18, 1.08)
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")

        // Animation
        animation.keyTimes = [0, 0.3, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false

        // Draw circles
        for i in 0 ..< 3 {
            let circle = CAShapeLayer()
            let path = UIBezierPath()
            let circlePathSize = CGSize(width: circleSize, height: circleSize)
            path.addArc(withCenter: CGPoint(x: circlePathSize.width / 2, y: circlePathSize.height / 2), radius: circlePathSize.width / 2,
                        startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: false)
            circle.fillColor = color.cgColor
            circle.backgroundColor = nil
            circle.path = path.cgPath
            circle.frame = CGRect(x: 0, y: 0, width: circlePathSize.width, height: circlePathSize.height)
            let frame = CGRect(x: x + circleSize * CGFloat(i) + circleSpacing * CGFloat(i), y: y, width: circleSize, height: circleSize)
            animation.beginTime = beginTime + beginTimes[i]
            circle.frame = frame
            circle.add(animation, forKey: "animation")
            layer.addSublayer(circle)
        }
    }
}
