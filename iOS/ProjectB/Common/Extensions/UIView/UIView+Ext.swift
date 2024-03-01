//
//  UIView+Ext.swift
//  ProjectB
//
//  Created by Dmytro on 2/26/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension UIView {
    public func fillTo(superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    public func anchorCenter(superview: UIView) {
        anchorCenterX(superview: superview)
        anchorCenterY(superview: superview)
    }
    
    @discardableResult
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil,
                       leading: NSLayoutXAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       trailing: NSLayoutXAxisAnchor? = nil,
                       topConstraint: CGFloat = 0,
                       leadingConstraint: CGFloat = 0,
                       bottomConstraint: CGFloat = 0,
                       trailingConstraint: CGFloat = 0,
                       widthConstraint: CGFloat = 0,
                       heightConstraint: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstraint))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstraint))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstraint))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstraint))
        }
        
        if widthConstraint > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstraint))
        }
        
        if heightConstraint > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstraint))
        }
        
        NSLayoutConstraint.activate(anchors)
        
        return anchors
    }
    
    public func multipliedHeight(_ parent: UIView, multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: parent.heightAnchor,
                                           multiplier: multiplier).isActive = true
    }
    
    public func multipliedWidth(_ parent: UIView, multiplier: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: parent.widthAnchor,
                                           multiplier: multiplier).isActive = true
    }
    
    public func anchorSize(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
    }

    public func anchorWidth(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: parent.widthAnchor).isActive = true
    }

    public func anchorHeight(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: parent.heightAnchor).isActive = true
    }

    public func proportional(multiplier: CGFloat) {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier).isActive = true
    }
    
    public func anchorCenterX(superview: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant).isActive = true
    }
    
    public func anchorCenterY(superview: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant).isActive = true
    }
}
