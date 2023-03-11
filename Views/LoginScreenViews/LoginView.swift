//
//  LoginView.swift
//  Word-Quiz-App
//
//  Created by Akın Çetin on 8.03.2023.
//

import UIKit

class LoginView: UIView {

    lazy var loginButton = CustomLoginButton(title: "Giriş Yap", color: .blue)
    lazy var signUpButton = CustomLoginButton(title: "Kayıt Ol", color: .red)
    lazy var emailTextField = CustomTextField(placeholderText: "E-Mailinizi Giriniz")
    lazy var passwordTextField = CustomTextField(placeholderText: "Şifrenizi Giriniz")
    lazy var stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, signUpButton])
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Giriş Yap"
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 32
        layer.zPosition = 1
        backgroundColor = UIColor(red: 225/255, green: 215/255, blue: 198/255, alpha: 1)
        addSubview(label)
        addSubview(stackView)
    }

    func configureStackView() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.anchor(top: label.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32))
        stackView.isUserInteractionEnabled = true
    }
}


