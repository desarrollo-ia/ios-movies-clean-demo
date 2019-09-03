//
//  CAGradientLayerExtension.swift
//  Cinelopis (CLEAN Demo)
//
//  Created by Eduardo Pacheco on 8/31/19.
//  Copyright © 2019 IA Interactive. All rights reserved.
//

import UIKit

extension CAGradientLayer {

    // MARK: - Init
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = colors.map({ $0.cgColor })
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 0.8)
    }

    // MARK: - Public Methods
    func createGradientImage() -> UIImage? {

        var image: UIImage?
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
