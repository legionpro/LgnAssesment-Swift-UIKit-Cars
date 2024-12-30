//
//  UIView+extension.swift
//  iOS_Cars
//
//  Created by Oleh Poremskyy on 29.12.2024.
//

import UIKit

extension UIView {

    static func spacer(size: CGFloat = 10, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()
        
        if layout == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        return spacer
    }

}


extension UIView {
    @objc
    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }

    func removeAllSubviews<T: UIView>(type: T.Type) {
        subviews
            .filter { $0.isMember(of: type) }
            .forEach { $0.removeFromSuperview() }
    }
}
