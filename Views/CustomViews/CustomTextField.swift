//
//  CustomTextField.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

final class CustomTextField: UITextField {

    let placeholderText: String
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        placeholder = placeholderText
        layer.cornerRadius = 16
        backgroundColor = .lightGray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
