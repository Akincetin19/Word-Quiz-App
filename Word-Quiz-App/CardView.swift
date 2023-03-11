//
//  CardView.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 11.03.2023.
//

import UIKit

class CardView: UIView {

    let button : UIButton = {
       
        let btn = UIButton(frame: .zero)
        btn.setTitle("Make Animations", for: .normal)
        btn.backgroundColor = .blue
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 32
        backgroundColor = .red
        addSubview(button)
        isUserInteractionEnabled = false
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCardViews(frame: CGRect, isUserInteractionEnable: Bool) {
        
        self.frame = frame
        isUserInteractionEnabled = isUserInteractionEnable
        alpha = alpha * 2
        layer.zPosition = layer.zPosition * 2
        
    }
    func configureViewWhenCreated(isUserInteractionEnable: Bool, alpha: CGFloat, zPosition: CGFloat) {
        
        self.alpha = alpha
        self.layer.zPosition = zPosition
        
    }
    
}
