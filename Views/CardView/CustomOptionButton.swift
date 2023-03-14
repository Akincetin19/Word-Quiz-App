//
//  CustomOptionButton.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 11.03.2023.
//

import UIKit

class CustomOptionButton: UIButton {

    
    let title : String
    
    init(title: String) {
        
        self.title = title
       
        super.init(frame: .zero)
        layer.cornerRadius = 16
        setTitleColor(.black, for: .normal)
        setTitle(title, for: .normal)
        backgroundColor = .white
        layer.borderColor = CGColor.init(red: 24/255, green: 24/255, blue: 31/255, alpha: 1)
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
