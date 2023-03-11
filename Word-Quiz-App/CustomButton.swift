//
//  CustomButton.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

final class CustomLoginButton: UIButton {

    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        
        self.title = title
        self.color = color
        
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        layer.cornerRadius = 16
        setTitleColor(.white, for: .normal)
        backgroundColor = color
        setTitle(title, for: .normal)
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
