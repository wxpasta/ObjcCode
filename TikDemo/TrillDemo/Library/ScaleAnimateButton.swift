//
//  ScaleAnimateButton.swift
//  TrillDemo
//
//  Created by magic-devel on 2020/10/9.
//

import UIKit

class ScaleAnimateButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // 当view 本身被添加到父视图之上时
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 添加一个点击事件
        addTarget(self, action: #selector(toggleSeleceted), for: .touchUpInside)
    }
    
    @objc func toggleSeleceted() {
        isSelected.toggle()
    }

    override var isSelected: Bool{
        get {
            super.isSelected
        }
        set {
            super.transform = .init(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [.beginFromCurrentState,.transitionCrossDissolve]) {
                super.isSelected = newValue
                super.transform = .identity
            } completion: { (_) in
                
            }
        }
    }
}
