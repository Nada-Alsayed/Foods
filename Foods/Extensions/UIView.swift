//
//  UIView.swift
//  Foods
//
//  Created by MAC on 27/11/2023.
//

import Foundation
import UIKit

extension UIView {
    func addBorder(to edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        switch edge {
        case UIRectEdge.top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        case UIRectEdge.bottom:
            borderLayer.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        case UIRectEdge.left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case UIRectEdge.right:
            borderLayer.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        default:
            break
        }

        layer.addSublayer(borderLayer)
    }
}

