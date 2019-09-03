//
//  UINavigationBarExtension.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func setBlueBackground() {
        self.isTranslucent = false
        self.barStyle = .black
        self.tintColor = .white
        let color1 = UIColor(red: 26.0 / 255.0, green: 84.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
        let color2 = UIColor(red: 26.0 / 255.0, green: 84.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: [color1, color2])
        self.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        ]

        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
    }
}
